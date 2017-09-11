--FECHA CREACION CLIENTES NOVA
DROP TABLE IF EXISTS FTORREN.STOCK_NOVA;

CREATE TABLE FTORREN.STOCK_NOVA (
ID_STOCK_NOVA INT IDENTITY,
ANO_MES INT,
RUT INT,
FEC_APER INT
)
CREATE UNIQUE
INDEX IDX_STOCK_NOVA
ON  FTORREN.STOCK_NOVA (ID_STOCK_NOVA,RUT)
WITH ALLOW_DUP_ROW;

CREATE INDEX IDX_ANOMES_RUT_SN ON FTORREN.STOCK_NOVA (ANO_MES,RUT);

INSERT INTO FTORREN.STOCK_NOVA(
ANO_MES,
RUT,
FEC_APER
)
SELECT 
DISTINCT
ANO_MES_DIA/100 AS ANO_MES,
RUT,
FEC_APER
FROM GESFOR.STOCK_NOVA
WHERE (ANO_MES = 201606
OR ANO_MES = 201706)
AND RUT <> ''


--FECHA CREACION CLIENTES CCT
DROP TABLE IF EXISTS FTORREN.STOCK_CCT;

CREATE TABLE FTORREN.STOCK_CCT (
ID_STOCK_CCT INT IDENTITY,
ANO_MES INT,
RUT INT,
FEC_APE INT
)
CREATE UNIQUE
INDEX IDX_STOCK_CCT
ON  FTORREN.STOCK_CCT (ID_STOCK_CCT,RUT)
WITH ALLOW_DUP_ROW;

CREATE INDEX IDX_ANOMES_RUT_CCT ON FTORREN.STOCK_CCT (ANO_MES,RUT);

INSERT INTO FTORREN.STOCK_CCT(
ANO_MES,
RUT,
FEC_APE
)
SELECT 
DISTINCT
ANO_MES_DIA/100 AS ANO_MES,
RUT,
CONVERT(INT,CONVERT(CHAR,FEC_APE,112)) AS FEC_APE
FROM GESFOR.STOCK_CCT
WHERE (ANO_MES = 201606
OR ANO_MES = 201706)
AND RUT <> ''

----FECHA_TC

--CREATE TABLE AND LOAD
DROP TABLE IF EXISTS FTORREN.STOCK_TCR;

CREATE TABLE FTORREN.STOCK_TCR (
ID_STOCK_TCR INT IDENTITY,
ANO_MES INT ,
RUT INT ,
FEC_APE INT
)
CREATE UNIQUE
INDEX IDX_STOCK_TCR
ON FTORREN.STOCK_TCR (ID_STOCK_TCR,RUT)
WITH ALLOW_DUP_ROW;

CREATE INDEX IDX_ANOMES_RUT_TCR ON FTORREN.STOCK_TCR (ANO_MES,RUT);

INSERT INTO FTORREN.STOCK_TCR(
ANO_MES,
RUT,
FEC_APE
)
SELECT
DISTINCT
ANO_MES_DIA/100 AS ANO_MES,
RUT,
CASE
WHEN FEC_APE_TRJ IS NULL THEN CONVERT(INT,CONVERT(CHAR,FEC_ACT_TRJ,112))
ELSE CONVERT(INT,CONVERT(CHAR,FEC_APE_TRJ,112))
END AS FEC_APE
FROM GESFOR.STOCK_TCR
WHERE (ANO_MES = 201606
OR ANO_MES = 201706)
AND RUT <> ''


--CREATE TABLE AND LOAD
DROP TABLE IF EXISTS FTORREN.REPORTE_V2;

CREATE TABLE FTORREN.REPORTE_V2 (
ID_REPORTE_V2 INT IDENTITY,
ANO_MES INT ,
RUT INT ,
DESC_BANCA VARCHAR(45),
IND_UTILIDAD VARCHAR(10),
IND_MOVIMIENTO VARCHAR(10),
IND_BALANCE VARCHAR(10),
APE_CCT INT,
APE_NVA INT,
APE_TCR INT
)
CREATE UNIQUE
INDEX IDX_REPORTE_V2
ON FTORREN.REPORTE_V2 (ID_REPORTE_V2,RUT)
WITH ALLOW_DUP_ROW;

CREATE INDEX IDX_ANOMES_RUT_RPTV2 ON FTORREN.REPORTE_V2 (ANO_MES,RUT);

INSERT INTO FTORREN.REPORTE_V2(
ANO_MES,
RUT,
DESC_BANCA,
IND_UTILIDAD,
IND_MOVIMIENTO,
IND_BALANCE,
APE_CCT,
APE_NVA,
APE_TCR
)
SELECT
RPT.ANO_MES,
RPT.RUT,
RPT.DESC_BANCA,
RPT.IND_UTILIDAD,
RPT.IND_MOVIMIENTO,
RPT.IND_BALANCE,
CCT.FEC_APE AS APE_CCT,
NVA.FEC_APER AS APE_NVA,
TCR.FEC_APE AS APE_TCR
FROM FTORREN.REPORTE RPT
LEFT JOIN FTORREN.STOCK_CCT CCT ON RPT.RUT = CCT.RUT AND RPT.ANO_MES = CCT.ANO_MES
LEFT JOIN FTORREN.STOCK_NOVA NVA ON RPT.RUT = NVA.RUT AND RPT.ANO_MES = NVA.ANO_MES
LEFT JOIN FTORREN.STOCK_TCR TCR ON RPT.RUT = TCR.RUT AND RPT.ANO_MES = TCR.ANO_MES



SELECT * FROM FTORREN.REPORTE_V2



FTORREN.RESUMEN_MOVIMIENTO
SELECT * FROM FTORREN.CLIENTES_ACTIVOS_POR_SALDO
WHERE RUT = 5391846



SELECT 'RESUMEN_TOT_CLIENTE' AS DESCRIPCION, RUT FROM FTORREN.RESUMEN_TOT_CLIENTE --UNIVERSO CLIENTES
WHERE RUT = 5392730
UNION ALL
SELECT 'RESUMEN_UTILIDAD' AS DESCRIPCION, RUT FROM FTORREN.RESUMEN_UTILIDAD --UTILIDAD <> 0 CLIENTES
WHERE RUT = 5392730
UNION ALL
SELECT 'RESUMEN_MOVIMIENTO' AS DESCRIPCION, RUT FROM FTORREN.RESUMEN_MOVIMIENTO --MOVIMIENTO DE SALDO ENTRE DIAS LOS ULTIMOS 6 MESES
WHERE RUT = 5392730
UNION ALL
SELECT 'RESUMEN_BALANCE' AS DESCRIPCION, RUT FROM FTORREN.RESUMEN_BALANCE --BALANCE MAYOR A 300USD
WHERE RUT = 5392730