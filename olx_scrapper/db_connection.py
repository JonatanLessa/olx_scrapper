import mysql.connector
import os
from dotenv import load_dotenv

load_dotenv()

database_connection = mysql.connector.connect(
    host='localhost',
    user=os.getenv('DATABASE_USER'),
    password=os.getenv('DATABASE_PASSWORD'),
    database=os.getenv('DATABASE_NAME')
)

def insert_TPM_ETL(brand, model, vehicle_year, km, advertiser_name, advertiser_type, city, district, moth, day, hour, price, state="Alagoas", year=2022, vehicle_power = 1):
    cursor = database_connection.cursor()
    sql = "INSERT INTO tmp_etl (MARCA, MODELO, ANO_VEICULO, KM, NOME_ANUNCIANTE, TIPO_ANUNCIANTE, CIDADE, BAIRRO, MES, DIA, HORA, PRECO, ESTADO, ANO, POTENCIA) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    cursor.execute(sql, (brand, model, vehicle_year, km, advertiser_name, advertiser_type, city, district, moth, day, hour, price, state, year, vehicle_power))
    database_connection.commit()
    cursor.close()

def insert_place():
    cursor = database_connection.cursor()
    sql = "INSERT INTO dm_local SELECT DISTINCT null, ESTADO, CIDADE, BAIRRO  FROM dw_olx_vehicle_database.tmp_etl"
    cursor.execute(sql)
    database_connection.commit()
    cursor.close()

def insert_vehicle():
    cursor = database_connection.cursor()
    sql = "INSERT INTO dm_veiculo SELECT DISTINCT null, MARCA, MODELO, ANO_VEICULO, POTENCIA, KM FROM dw_olx_vehicle_database.tmp_etl"
    cursor.execute(sql)
    database_connection.commit()
    cursor.close()

def insert_advertiser():
    cursor = database_connection.cursor()
    sql = "INSERT INTO dm_anunciante SELECT DISTINCT null, NOME_ANUNCIANTE, TIPO_ANUNCIANTE FROM dw_olx_vehicle_database.tmp_etl"
    cursor.execute(sql)
    database_connection.commit()
    cursor.close()

def insert_date():
    cursor = database_connection.cursor()
    sql = "INSERT INTO dm_tempo SELECT DISTINCT null, ANO, MES, DIA, HORA FROM dw_olx_vehicle_database.tmp_etl"
    cursor.execute(sql)
    database_connection.commit()
    cursor.close()

def insert_fact_ads():
    cursor = database_connection.cursor()
    sql = "INSERT IGNORE INTO dm_fato_anuncios SELECT v.ID_VEICULO, t.ID_TEMPO, l.ID_LOCAL, a.ID_ANUNCIANTE, x.PRECO FROM dw_olx_vehicle_database.tmp_etl x, dw_olx_vehicle_database.dm_local  l, dw_olx_vehicle_database.dm_veiculo v, dw_olx_vehicle_database.dm_anunciante a, dw_olx_vehicle_database.dm_tempo t WHERE x.ESTADO = l.ESTADO AND x.CIDADE = l.CIDADE AND x.BAIRRO = l.BAIRRO AND x.MARCA = v.MARCA AND x.MODELO = v.MODELO AND x.ANO_VEICULO = v.ANO AND x.POTENCIA = v.POTENCIA AND x.KM = v.KM AND x.ANO = t.ANO AND x.MES = t.MES AND x.DIA = t.DIA AND x.HORA = t.HORA AND x.NOME_ANUNCIANTE = a.NOME AND x.TIPO_ANUNCIANTE = a.TIPO"
    cursor.execute(sql)
    database_connection.commit()
    cursor.close()

def close_db_connection():
    database_connection.close()
