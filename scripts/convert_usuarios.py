#!/usr/bin/env python3
"""
Converte CSV Bubble User para formato tabela usuarios (Supabase).
Ordem e nomes das colunas = schema usuarios (migracao 00016).
Empresa_web_nome e empresa_app_nome sao mantidos para o loader resolver empresa_web_id e empresa_app_id.
Fonte esperada: bubble-export/data/User.csv (exportar tipo User no Bubble).
"""
import csv
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC_CSV = ROOT / "bubble-export" / "data" / "Users.csv"
OUT_CSV = ROOT / "supabase" / "seed-data" / "usuarios.csv"

# Mapeamento: (nome_coluna_saida, [possiveis_nomes_header_no_CSV_bubble])
# Ordem de saída = usuarios (empresa_web_nome, empresa_app_nome primeiro para FK; depois 1:1)
OUT_COLUMNS = [
    ("empresa_web_nome", ["001_EmpresaWeb", "001_Empresa Web", "EmpresaWeb"]),
    ("empresa_app_nome", ["002_EmpresaApp", "002_Empresa App", "EmpresaApp"]),
    ("bubble_unique_id", ["unique id", "unique_id", "Unique ID"]),
    ("cpf", ["CPF"]),
    ("nome", ["nome", "02 - nomeUsuario", "02_nomeUsuario", "nomeUsuario"]),
    ("sobrenome", ["03 - sobrenomeUsuario", "03_sobrenomeUsuario", "sobrenomeUsuario"]),
    ("email", ["04 - emailUsuario", "04_emailUsuario", "emailUsuario"]),
    ("telefone", ["Telefone"]),
    ("telefone_mascarado", ["telefone_mascarado", "17_telefone_mascarado"]),
    ("telefone_whatsapp", ["telefone_whatsapp"]),
    ("data_nascimento", ["DATA NASCI", "DATA_NASCI", "5 - DATA NASCI"]),
    ("foto_url", ["07 - fotoUsuario", "07_fotoUsuario", "fotoUsuario"]),
    ("funcao_logada_ref", ["20 - FUNCAO_LOGADA", "20_FUNCAO_LOGADA", "FUNCAO_LOGADA"]),
    ("funcao_vinculada_ref", ["21 - FUNCAO_VINCULADA", "21_FUNCAO_VINCULADA", "FUNCAO_VINCULADA"]),
    ("departamento", ["08 - departamentoUsuario", "08_departamentoUsuario", "departamentoUsuario"]),
    ("perfil", ["05 - perfilUsuario", "05_perfilUsuario", "perfilUsuario"]),
    ("ativo", ["01 - ativo", "01_ativo", "ativo"]),
    ("basico_completo", ["basico_completo"]),
    ("acesso_master", ["82 - Acesso Master", "82_Acesso Master", "Acesso Master"]),
    ("logo_empresa_url", ["LogoEmpresa", "06_LogoEmpresa"]),
    ("logo_empresa2_url", ["Logo_empresa2", "09_Logo_empresa2"]),
    ("crm_nome_chat", ["50 - CRM-NOME_CHAT", "50_CRM-NOME_CHAT", "CRM-NOME_CHAT"]),
    ("crm_dados_user_ref", ["51 - CRM-DADOS_USER", "51_CRM-DADOS_USER", "CRM-DADOS_USER"]),
    ("whatsapp_instancia_ref", ["WhatsApp-Instancia", "26_WhatsApp-Instancia"]),
    ("ultimo_changelog", ["81 - ULTIMO_CHANGELOG", "81_ULTIMO_CHANGELOG", "ULTIMO_CHANGELOG"]),
    ("nps", ["NPS"]),
    ("nps_geral_respondido", ["NPS-GERAL-RESPONDIDO", "NPS_GERAL_RESPONDIDO"]),
    ("como_conheceu", ["Como_conheceu", "7_Como_conheceu"]),
    ("token", ["Token"]),
    ("pesquisa_churn_ref", ["[TEMP] - Pesquisa CHURN", "TEMP_Pesquisa CHURN", "Pesquisa CHURN"]),
    ("atualiza_pag", ["88 - AtualizaPag", "88_AtualizaPag", "AtualizaPag"]),
    ("permissao_inativo", ["INATIVO-Usuario_permissao", "INATIVO_Usuario_permissao"]),
    ("created_at", ["Creation Date", "Creation date", "Created Date"]),
    ("updated_at", ["Modified Date", "Modified date", "Updated Date"]),
    ("created_by", ["Creator", "Created by"]),
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
    return (s or "").strip().lower() in ("sim", "yes", "true", "1")


def get_indices(header_index: dict[str, int]) -> list[tuple[str, int | None]]:
    """Para cada OUT_COLUMNS, retorna (out_name, indice_csv) ou (out_name, None)."""
    result = []
    for out_name, possible_headers in OUT_COLUMNS:
        idx = None
        for h in possible_headers:
            if h in header_index:
                idx = header_index[h]
                break
            if h.lower() in header_index:
                idx = header_index[h.lower()]
                break
        result.append((out_name, idx))
    return result


def row_to_v2(row: list[str], indices: list[tuple[str, int | None]]) -> list[str]:
    def get(idx: int | None) -> str:
        if idx is None or idx >= len(row):
            return ""
        return (row[idx].strip() if row[idx] else "") or ""

    out = []
    for name, idx in indices:
        val = get(idx)
        if name in ("created_at", "updated_at", "data_nascimento"):
            out.append(parse_bubble_date(val) or "")
        elif name in ("ativo", "nps_geral_respondido", "acesso_master", "basico_completo"):
            out.append("true" if bubble_bool(val) else "false")
        elif name == "atualiza_pag":
            out.append("true" if bubble_bool(val) else "false")
        else:
            out.append(val)
    return out


def main():
    if not SRC_CSV.exists():
        raise SystemExit(
            f"Arquivo não encontrado: {SRC_CSV}\n"
            "Exporte o tipo User do Bubble e salve em bubble-export/data/Users.csv"
        )

    OUT_CSV.parent.mkdir(parents=True, exist_ok=True)

    with open(SRC_CSV, newline="", encoding="utf-8") as f_in:
        reader = csv.reader(f_in)
        headers = next(reader)
        # header_index por nome exato (strip)
        header_index = {h.strip(): i for i, h in enumerate(headers)}
        # fallback: minusculas
        for i, h in enumerate(headers):
            k = h.strip().lower()
            if k and k not in header_index:
                header_index[k] = i
        indices = get_indices(header_index)
        rows = list(reader)

    converted = [row_to_v2(row, indices) for row in rows]

    with open(OUT_CSV, "w", newline="", encoding="utf-8") as f_out:
        w = csv.writer(f_out)
        w.writerow(OUT_HEADERS)
        w.writerows(converted)

    print(f"Convertidas {len(converted)} linhas -> {OUT_CSV}")


if __name__ == "__main__":
    main()
