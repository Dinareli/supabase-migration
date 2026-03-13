#!/usr/bin/env python3
"""
Gera SQL de seed a partir dos CSV em supabase/seed-data/.
Compatível com supabase/migrations/ (00002 empresas, 00016 usuarios, assinaturas).
Ordem: INSERT empresas, depois INSERT usuarios (empresa_web_id/empresa_app_id por subquery), depois assinaturas.
"""
import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SEED_DIR = ROOT / "supabase" / "seed-data"
OUT_SQL = SEED_DIR / "seed_empresas_assinaturas.sql"

# Colunas empresas = 00002_create_empresas.sql (sem id)
EMPRESAS_COLS = [
    "bubble_unique_id", "nome", "cnpj", "email", "telefone", "instagram", "endereco",
    "logo_url", "slug", "plano", "recorrencia", "acesso_ate", "ultimo_acesso",
    "limite_usuarios", "qtd_vendedores", "usuario_adicional", "ativo", "cadastro_completo",
    "primeiro_acesso", "aguardando_aprovacao", "beta", "super_beta", "novos_modelos",
    "novas_cores", "info_pagto_assinatura", "assinatura_irregular", "primeiro_pagto",
    "adiciona_dias", "fiscal_ativo", "fiscal_cnpj", "fiscal_ie", "regime_tributario",
    "certificado_ref", "rf_fiscal_ref", "addon_assistencia", "addon_emp_fiscal",
    "addon_os_planos", "asaas_customer_id", "assinatura_ref", "api_key", "project_ref",
    "carteira_ref", "engajamento_ref", "fatura_url", "configuracoes_gerais",
    "crm_acesso_ate", "termos", "termo_empresa", "id_visual",
    "created_at", "updated_at", "created_by",
]

# Colunas usuarios = 00016 schema (empresa_web_id e empresa_app_id por subquery em nome)
USUARIOS_COLS = [
    "bubble_unique_id", "nome", "sobrenome", "email", "cpf", "telefone", "telefone_mascarado",
    "telefone_whatsapp", "data_nascimento", "foto_url", "funcao_logada_ref", "funcao_vinculada_ref",
    "departamento", "perfil", "ativo", "basico_completo", "acesso_master", "logo_empresa_url",
    "logo_empresa2_url", "crm_nome_chat", "crm_dados_user_ref", "whatsapp_instancia_ref",
    "ultimo_changelog", "nps", "nps_geral_respondido", "como_conheceu", "token", "pesquisa_churn_ref",
    "atualiza_pag", "permissao_inativo", "created_at", "updated_at", "created_by",
]

# Colunas assinaturas = 00016 (empresa_id vem de subquery, não do CSV)
ASSINATURAS_COLS = [
    "bubble_unique_id", "asaas_customer_id", "asaas_descricao", "asaas_parcela",
    "asaas_evento", "asaas_status", "asaas_valor_recebido", "mensalidade", "plano",
    "recorrencia", "total_pago", "ticket_medio", "data_criacao_assinatura",
    "data_acesso_ate", "data_cancelamento", "ativo", "cancelado", "motivo_cancelamento",
    "tipo_motivo_cancelamento", "nome_assinante", "contato_assinante", "cidade_assinante",
    "uf_assinante", "observacoes", "forma_entrada", "cupom_ativado", "d_token",
    "created_at", "updated_at", "created_by",
]


def esc(s: str) -> str:
    if s is None or str(s).strip() == "":
        return "NULL"
    return "'" + str(s).replace("\\", "\\\\").replace("'", "''").replace("\r", " ").replace("\n", " ") + "'"


def sql_val(val: str, col: str) -> str:
    val = (val or "").strip()
    if val == "" or val.upper() == "NULL":
        return "NULL"
    # boolean (empresas + usuarios + assinaturas)
    if col in ("ativo", "cancelado", "cadastro_completo", "primeiro_acesso", "aguardando_aprovacao",
               "beta", "super_beta", "novos_modelos", "novas_cores", "info_pagto_assinatura",
               "assinatura_irregular", "primeiro_pagto", "adiciona_dias", "fiscal_ativo", "addon_assistencia",
               "nps_geral_respondido", "acesso_master"):
        return "true" if val.lower() == "true" else "false"
    if col == "basico_completo":
        return "true" if val.lower() == "true" else "false"
    # integer
    if col in ("limite_usuarios", "qtd_vendedores", "usuario_adicional") and val != "":
        try:
            return str(int(float(val)))
        except ValueError:
            return "NULL"
    # numeric (00016: asaas_parcela é text)
    if col in ("asaas_valor_recebido", "mensalidade", "total_pago", "ticket_medio") and val != "":
        try:
            return str(float(val))
        except ValueError:
            return "NULL"
    if col == "addon_emp_fiscal" and val != "":
        try:
            return str(int(float(val)))
        except ValueError:
            return esc(val)
    return esc(val)


def main():
    n_usu = 0
    out = []
    out.append("-- Seed: empresas + usuarios + assinaturas (supabase/migrations 00002, 00016)")
    out.append("-- Gerado por scripts/seed_to_sql.py")
    out.append("")

    empresas_csv = SEED_DIR / "empresas.csv"
    if not empresas_csv.exists():
        raise SystemExit(f"Arquivo não encontrado: {empresas_csv}")

    with open(empresas_csv, newline="", encoding="utf-8") as f:
        empresas_rows = list(csv.DictReader(f))

    out.append(f"-- {len(empresas_rows)} empresas")
    for row in empresas_rows:
        vals = [sql_val(row.get(c, ""), c) for c in EMPRESAS_COLS]
        out.append("INSERT INTO empresas (" + ", ".join(EMPRESAS_COLS) + ")")
        out.append("VALUES (" + ", ".join(vals) + ");")

    out.append("")
    # Usuarios (empresa_web_id e empresa_app_id por subquery em nome)
    usuarios_csv = SEED_DIR / "usuarios.csv"
    if usuarios_csv.exists():
        out.append("-- Usuarios (empresa_web_id e empresa_app_id por subquery em nome)")
        out.append("")
        with open(usuarios_csv, newline="", encoding="utf-8") as f:
            u_rows = list(csv.DictReader(f))
        for row in u_rows:
            empresa_web_nome = (row.get("empresa_web_nome") or "").strip().replace("'", "''")
            empresa_app_nome = (row.get("empresa_app_nome") or "").strip().replace("'", "''")
            empresa_web_id = "(SELECT id FROM empresas WHERE trim(nome) = trim(" + esc(empresa_web_nome) + ") LIMIT 1)" if empresa_web_nome else "NULL"
            empresa_app_id = "(SELECT id FROM empresas WHERE trim(nome) = trim(" + esc(empresa_app_nome) + ") LIMIT 1)" if empresa_app_nome else "NULL"
            vals = [
                sql_val(row.get("bubble_unique_id", ""), "bubble_unique_id"),
                empresa_web_id,
                empresa_app_id,
            ]
            for c in USUARIOS_COLS:
                if c == "bubble_unique_id":
                    continue
                vals.append(sql_val(row.get(c, ""), c))
            cols = ["bubble_unique_id", "empresa_web_id", "empresa_app_id"] + [c for c in USUARIOS_COLS if c != "bubble_unique_id"]
            out.append("INSERT INTO usuarios (" + ", ".join(cols) + ")")
            out.append("VALUES (" + ", ".join(vals) + ");")
        out.append("")
        out.append(f"-- {len(u_rows)} usuarios")
        out.append("")
        n_usu = len(u_rows)
    else:
        n_usu = 0
        out.append("-- (usuarios.csv nao encontrado; pule esta secao)")
        out.append("")

    out.append("-- Assinaturas (empresa_id por subquery em nome)")
    out.append("")

    assinaturas_csv = SEED_DIR / "assinaturas.csv"
    if not assinaturas_csv.exists():
        raise SystemExit(f"Arquivo não encontrado: {assinaturas_csv}")

    with open(assinaturas_csv, newline="", encoding="utf-8") as f:
        assinaturas_rows = list(csv.DictReader(f))

    for row in assinaturas_rows:
        empresa_nome = (row.get("empresa_nome") or "").strip().replace("'", "''")
        vals = [
            "(SELECT id FROM empresas WHERE trim(nome) = trim(" + esc(empresa_nome) + ") LIMIT 1)",
            sql_val(row.get("bubble_unique_id", ""), "bubble_unique_id"),
        ]
        for c in ASSINATURAS_COLS:
            if c == "bubble_unique_id":
                continue
            # created_by em assinaturas é bigint (FK usuarios.id); CSV traz texto/email -> NULL
            if c == "created_by":
                v = (row.get(c) or "").strip()
                vals.append(v if v.isdigit() else "NULL")
                continue
            vals.append(sql_val(row.get(c, ""), c))
        cols = ["empresa_id", "bubble_unique_id"] + [c for c in ASSINATURAS_COLS if c != "bubble_unique_id"]
        out.append("INSERT INTO assinaturas (" + ", ".join(cols) + ")")
        out.append("VALUES (" + ", ".join(vals) + ");")

    OUT_SQL.write_text("\n".join(out), encoding="utf-8")
    print(f"Gerado {OUT_SQL} ({len(empresas_rows)} empresas, {n_usu} usuarios, {len(assinaturas_rows)} assinaturas)")


if __name__ == "__main__":
    main()
