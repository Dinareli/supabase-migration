#!/usr/bin/env python3
"""
Converte CSV Bubble DB002_EMPRESAS para formato output/bubble_supabase.sql (tabela empresas).
Ordem e nomes das colunas = bubble_supabase.sql (migracao 1:1 com DB002 1-53).
"""
import csv
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC_CSV = ROOT / "bubble-export" / "data" / "DB002_EMPRESAS.csv"
OUT_CSV = ROOT / "supabase" / "seed-data" / "empresas.csv"

# Ordem de saída = bubble_supabase.sql empresas (após id, bubble_unique_id)
# Cada entrada: (nome_coluna, índice_no_CSV_bubble) ou (nome, None) para derivado
OUT_COLUMNS = [
    ("bubble_unique_id", 57),
    ("cnpj", 12),
    ("api_key", 39),
    ("instagram", 16),
    ("acesso_ate", 0),
    ("fatura_url", 43),
    ("asaas_customer_id", 10),
    ("nome", 19),
    ("engajamento_ref", 42),
    ("fiscal_ie", 8),
    ("beta", 25),
    ("termo_empresa", 23),
    ("qtd_vendedores", 21),
    ("recorrencia", 3),
    ("fiscal_cnpj", 7),
    ("comercial_status", 13),
    ("primeiro_acesso", 20),
    ("endereco", 14),
    ("telefone", 22),
    ("limite_usuarios", 17),
    ("logo_url", 18),
    ("plano", 5),
    ("addon_os_planos", 47),
    ("novas_cores", 33),
    ("certificado_ref", 29),
    ("adiciona_dias", 38),
    ("primeiro_pagto", 44),
    ("fiscal_ativo", 6),
    ("cadastro_completo", 11),
    ("id_unico", 45),
    ("novos_modelos", 4),
    ("super_beta", 26),
    ("email", 32),
    ("ultimo_acesso", 1),
    ("usuario_adicional", 24),
    ("crm_acesso_ate", 37),
    ("info_pagto_assinatura", 15),
    ("project_ref", 48),
    ("assinatura_irregular", 41),
    ("addon_emp_fiscal", 35),
    ("addon_assistencia", 34),
    ("engajamento_count_2025", 51),
    ("engajamento_count_2026", 52),
    ("aguardando_aprovacao", 31),
    ("regime_tributario", 49),
    ("carteira_ref", 36),
    ("assinatura_ref", 40),
    ("id_visual", 28),
    ("rf_fiscal_ref", 30),
    ("termos", 27),
    ("configuracoes_gerais", 46),
    ("regime_trib", 9),
    ("ativo", None),  # derivado: false se plano == Inativo
    ("slug", 55),
    ("created_at", 53),
    ("updated_at", 54),
    ("created_by", 56),
]

OUT_HEADERS = [c[0] for c in OUT_COLUMNS]

BUBBLE_DATE_FMT = "%b %d, %Y %I:%M %p"


def parse_bubble_date(s: str) -> str | None:
    if not s or not (s := s.strip()):
        return None
    try:
        dt = datetime.strptime(s, BUBBLE_DATE_FMT)
        return dt.strftime("%Y-%m-%dT%H:%M:%S")
    except ValueError:
        return None


def bubble_bool(s: str) -> bool:
    return (s or "").strip().lower() == "sim"


def bubble_int(s: str) -> str:
    if not s or not (s := s.strip()):
        return ""
    s = s.replace(",", ".")
    try:
        return str(int(float(s)))
    except ValueError:
        return ""


def bubble_numeric(s: str) -> str:
    if not s or not (s := s.strip()):
        return ""
    s = s.replace(",", ".")
    try:
        return f"{float(s):.2f}"
    except ValueError:
        return ""


def row_to_v2(row: list[str]) -> list[str]:
    def get(i: int) -> str:
        return (row[i].strip() if i < len(row) else "") or ""

    out = []
    for name, idx in OUT_COLUMNS:
        if name == "ativo":
            plano = get(5)
            out.append("false" if plano.strip().lower() == "inativo" else "true")
            continue
        if idx is None:
            out.append("")
            continue
        val = get(idx)
        if name in ("acesso_ate", "ultimo_acesso", "crm_acesso_ate", "created_at", "updated_at"):
            out.append(parse_bubble_date(val) or "")
        elif name in ("beta", "primeiro_acesso", "novas_cores", "adiciona_dias", "primeiro_pagto", "fiscal_ativo",
                      "cadastro_completo", "novos_modelos", "super_beta", "info_pagto_assinatura",
                      "assinatura_irregular", "addon_assistencia", "aguardando_aprovacao"):
            out.append("true" if bubble_bool(val) else "false")
        elif name in ("qtd_vendedores", "limite_usuarios", "usuario_adicional"):
            out.append(bubble_int(val) or "")
        elif name in ("engajamento_count_2025", "engajamento_count_2026"):
            out.append(bubble_numeric(val) or "")
        elif name == "addon_emp_fiscal":
            out.append(bubble_int(val) or val or "")
        else:
            out.append(val)
    return out


def main():
    if not SRC_CSV.exists():
        raise SystemExit(f"Arquivo não encontrado: {SRC_CSV}")

    OUT_CSV.parent.mkdir(parents=True, exist_ok=True)

    with open(SRC_CSV, newline="", encoding="utf-8") as f_in:
        reader = csv.reader(f_in)
        next(reader)
        rows = list(reader)

    converted = [row_to_v2(row) for row in rows]

    with open(OUT_CSV, "w", newline="", encoding="utf-8") as f_out:
        w = csv.writer(f_out)
        w.writerow(OUT_HEADERS)
        w.writerows(converted)

    print(f"Convertidas {len(converted)} linhas -> {OUT_CSV}")


if __name__ == "__main__":
    main()
