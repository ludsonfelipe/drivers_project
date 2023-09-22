from datetime import timedelta, date
import datetime
from pyspark.sql.types import StructType, StructField, IntegerType, StringType,array,ArrayType,DateType,TimestampType


bronze_layer = 'gs://bronze-layer-cebc3c7c150affd8/'
postgres_data = 'database_data/'
silver_layer = 'gs://silver-layer-cebc3c7c150affd8/'
UPDATED=datetime.datetime.today().replace(second=0, microsecond=0)


import pandas as pd
df = pd.read_json('gs://bronze-layer-cebc3c7c150affd8/database_data/public_motoristas/2023/09/21/18/50/8860e0e1443ae5b9c2dd41b8b1e4a32f924bc4fe_postgresql-cdc_465564840_5_0.jsonl', lines=True)


schema_usuarios = StructType([
    StructField("usuario_id", IntegerType(), False),
    StructField("nome", StringType(), True),
    StructField("email", StringType(), True),
    StructField("senha", StringType(), True),
    StructField("telefone", StringType(), True),
    StructField("endereco", StringType(), True)
])

schema_motoristas = StructType([
    StructField("motorista_id", IntegerType(), False),
    StructField("usuario_id", IntegerType(), True),
    StructField("avaliacao", DecimalType(3, 2), True),
    StructField("status", StringType(), True)
])

schema_veiculos = StructType([
    StructField("veiculo_id", IntegerType(), False),
    StructField("motorista_id", IntegerType(), True),
    StructField("modelo", StringType(), True),
    StructField("ano", IntegerType(), True),
    StructField("placa", StringType(), True)
])

schema_viagens = StructType([
    StructField("viagem_id", IntegerType(), False),
    StructField("usuario_id", IntegerType(), True),
    StructField("motorista_id", IntegerType(), True),
    StructField("veiculo_id", IntegerType(), True),
    StructField("data_hora_inicio", TimestampType(), True),
    StructField("data_hora_fim", TimestampType(), True),
    StructField("origem", StringType(), True),
    StructField("destino", StringType(), True),
    StructField("status", StringType(), True)
])

schema_pagamentos = StructType([
    StructField("pagamento_id", IntegerType(), False),
    StructField("viagem_id", IntegerType(), True),
    StructField("valor", DecimalType(10, 2), True),
    StructField("status", StringType(), True)
])

