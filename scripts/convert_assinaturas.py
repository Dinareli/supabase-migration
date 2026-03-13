#!/usr/bin/env python3
"""
Converte CSV Bubble DB001_ASSINATURAS para formato output/bubble_supabase.sql (tabela assinaturas).
Ordem e nomes das colunas = bubble_supabase.sql (migracao 1:1 com DB001 1-27).
empresa_nome é mantido para o loader resolver empresa_id.
"""
import csv
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC_CSV = ROOT / "bubble-export" / "data" / "DB001_ASSINATURAS.csv"
OUT_CSV = ROOT / "supabase" / "seed-data" / "assinaturas.csv"

# Ordem de saída = bubble_supabase.sql assinaturas (empresa_nome primeiro para FK; depois ordem 1:1)
# (nome_coluna, índice_no_CSV_bubble)
OUT_COLUMNS = [
    ("empresa_nome", 0),
    ("bubble_unique_id", 31),
    ("cupom_ativado", 25),
    ("asaas_evento", 22),
    ("asaas_status", 23),
    ("mensalidade", 4),
    ("d_token", 26),
    ("asaas_customer_id", 1),
    ("asaas_valor_recebido", 24),
    ("asaas_descricao", 2),
    ("asaas_parcela", 3),
    ("recorrencia", 6),
    ("total_pago", 7),
    ("cancelado", 12),
    ("uf_assinante", 19),
    ("ticket_medio", 8),
    ("nome_assinante", 16),
    ("data_acesso_ate", 10),
    ("cidade_assinante", 17),
    ("forma_entrada", 21),
    ("data_cancelamento", 15),
    ("contato_assinante", 18),
    ("plano", 5),
    ("ativo", 11),
    ("motivo_cancelamento", 13),
    ("observacoes", 20),
    ("data_criacao_assinatura", 9),
    ("tipo_motivo_cancelamento", 14),
    ("created_at", 27),
    ("updated_at", 28),
    ("created_by", 30),
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


def bubble_numeric(s: str) -> str | None:
    if not s or not (s := s.strip()):
        return None
    s = s.replace(",", ".")
    try:
        return f"{float(s):.2f}"
    except ValueError:
        return None


def row_to_v2(row: list[str]) -> list[str]:
    def get(i: int) -> str:
        return (row[i].strip() if i < len(row) else "") or ""

    out = []
    for name, idx in OUT_COLUMNS:
        val = get(idx)
        if name in ("data_acesso_ate", "data_cancelamento", "data_criacao_assinatura", "created_at", "updated_at"):
            out.append(parse_bubble_date(val) or "")
        elif name in ("ativo", "cancelado"):
            out.append("true" if bubble_bool(val) else "false")
        elif name in ("mensalidade", "asaas_valor_recebido", "total_pago", "ticket_medio", "asaas_parcela"):
            out.append(bubble_numeric(val) or "")
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
