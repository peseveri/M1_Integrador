from sqlalchemy import create_engine, inspect
from dotenv import load_dotenv
import os
import json
import pandas as pd

load_dotenv()

def get_database_url():
    user = os.getenv("DB_USER")
    password = os.getenv("DB_PASSWORD")
    host = os.getenv("DB_HOST")
    port = os.getenv("DB_PORT")
    db = os.getenv("DB_NAME")
    return f"mysql+pymysql://{user}:{password}@{host}:{port}/{db}"

def columnas_semiestructuradas(engine, tabla):
    inspector = inspect(engine)
    columnas = inspector.get_columns(tabla)
    candidatas = []
    from sqlalchemy.dialects.mysql import JSON as MySQLJSON
    from sqlalchemy.types import Text

    for col in columnas:
        tipo = col['type']
        if isinstance(tipo, MySQLJSON) or isinstance(tipo, Text):
            candidatas.append(col['name'])
    return candidatas

def extraer_json_valido(df, columna, pk_col):
    json_rows = []
    ids = []

    for _, row in df.iterrows():
        try:
            data = json.loads(row[columna])
            if isinstance(data, dict):
                json_rows.append(data)
                ids.append(row[pk_col])
        except (json.JSONDecodeError, TypeError):
            continue

    if not json_rows:
        return pd.DataFrame()

    df_json = pd.DataFrame(json_rows)
    df_json.insert(0, pk_col, ids)
    return df_json

def transformar_si_es_json(engine, tabla_origen, columna_json, tabla_destino):
    inspector = inspect(engine)
    pk_constraint = inspector.get_pk_constraint(tabla_origen)
    pk_cols = pk_constraint.get('constrained_columns', [])

    if not pk_cols:
        print(f"⚠️ La tabla `{tabla_origen}` no tiene PK definida, no se puede continuar.")
        return
    pk_col = pk_cols[0]

    candidatas = columnas_semiestructuradas(engine, tabla_origen)
    if columna_json not in candidatas:
        print(f"ℹ️ La columna `{columna_json}` en `{tabla_origen}` no es detectada como semiestructurada (JSON/TEXT).")
        return

    print(f"🔍 Revisando `{tabla_origen}`.{columna_json} con PK `{pk_col}` porque es tipo semiestructurado.")

    query = f"SELECT {pk_col}, {columna_json} FROM {tabla_origen} WHERE {columna_json} IS NOT NULL"
    df = pd.read_sql(query, engine)

    df_struct = extraer_json_valido(df, columna_json, pk_col)

    if df_struct.empty:
        print(f"⚠️ No se encontraron datos JSON válidos en `{tabla_origen}`.{columna_json} pese a ser texto semiestructurado.")
        return

    df_struct.to_sql(tabla_destino, engine, index=False, if_exists='replace')
    print(f"✅ Tabla `{tabla_destino}` creada con {len(df_struct)} filas y {len(df_struct.columns)} columnas.")

def procesar_todas_tablas(engine):
    inspector = inspect(engine)
    tablas = inspector.get_table_names()

    for tabla in tablas:
        candidatas = columnas_semiestructuradas(engine, tabla)
        if candidatas:
            print(f"\n📋 Tabla `{tabla}` tiene columnas semiestructuradas detectadas: {candidatas}")
            for col in candidatas:
                transformar_si_es_json(engine, tabla, col, f"{tabla}_{col}_struct")
        else:
            print(f"\n✅ Tabla `{tabla}` no tiene columnas semiestructuradas detectadas.")

if __name__ == "__main__":
    engine = create_engine(get_database_url())
    procesar_todas_tablas(engine)
