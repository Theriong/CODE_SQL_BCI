--PRIMERA CARGA
DROP TABLE FTORREN.STOCK_VAR_DIA;

CREATE TABLE FTORREN.STOCK_VAR_DIA (
			ID_C_COL INT IDENTITY,
			FEC_PROC INT,  
			REGION VARCHAR(50),
		    PLATAFORMA VARCHAR(50),
			EJECUTIVO VARCHAR(50),
			SDO_OPE DECIMAL(30,6),
			VAR_SDO_DIA_ANT DECIMAL(30,6),
			SDO_PROM_ACUM DECIMAL(30,6),
			VAR_SDO_MES_ANT DECIMAL(30,6),
			VAR_SDO_PROM_DIA_ANT DECIMAL(30,6),
			VAR_SDO_PROM_MES_ANT DECIMAL(30,6),
			VAR_SDO_PROM_TRIM_ANT DECIMAL(30,6),
			VAR_SDO_OPE_TRIM_ANT DECIMAL(30,6)
)
CREATE UNIQUE
INDEX IDX_STOCK_VAR_DIA
ON  FTORREN.STOCK_VAR_DIA (ID_C_COL,FEC_PROC,REGION,PLATAFORMA,EJECUTIVO)
WITH ALLOW_DUP_ROW;

INSERT INTO FTORREN.STOCK_VAR_DIA(
			FEC_PROC,
			REGION,
		    PLATAFORMA,
			EJECUTIVO,
			SDO_OPE,
			VAR_SDO_DIA_ANT,
			SDO_PROM_ACUM,
			VAR_SDO_MES_ANT,
			VAR_SDO_PROM_DIA_ANT,
			VAR_SDO_PROM_MES_ANT,
			VAR_SDO_PROM_TRIM_ANT,
			VAR_SDO_OPE_TRIM_ANT
)
SELECT
FEC_PROC,
EJE_CLI AS EJECUTIVO,
PLT_CLI AS PLATAFORMA,
REG_CLI AS REGION,
SUM(SDO_OPE)/1000 AS SDO_OPE,
SUM(SDO_PROM_ACUM)/1000 AS SDO_PROM_ACUM,
SUM(VAR_SDO_DIA_ANT)/1000 AS VAR_SDO_DIA_ANT,
SUM(VAR_SDO_MES_ANT)/1000 AS VAR_SDO_MES_ANT,
SUM(VAR_SDO_PROM_DIA_ANT)/1000 AS VAR_SDO_PROM_DIA_ANT,
SUM(VAR_SDO_PROM_MES_ANT)/1000 AS VAR_SDO_PROM_MES_ANT,
SUM(VAR_SDO_PROM_TRIM_ANT)/1000 AS VAR_SDO_PROM_TRIM_ANT,
SUM(VAR_SDO_OPE_TRIM_ANT)/1000 AS VAR_SDO_OPE_TRIM_ANT
FROM SGC.STOCK_VAR_DIA
WHERE FEC_PROC > CAST(DATEFORMAT(DATEADD(MONTH,-13,NOW()),'YYYYMMDD') AS INT)
AND TRIM(BCA) IN ('EM','EMQ')
AND RUT<>'76804710'
AND EJE_CLI = 'FPIMENB'
AND PLT_CLI IS NOT NULL
AND REG_CLI IS NOT NULL
GROUP BY 
	FEC_PROC,
	EJE_CLI,
	PLT_CLI,
	REG_CLI
	

--SEGUNDA CARGA
DROP TABLE FTORREN.C_COL;

CREATE TABLE FTORREN.C_COL (
			ID_C_COL INT IDENTITY,
			FEC_PROC INT,  
			REGION VARCHAR(50),
		    PLATAFORMA VARCHAR(50),
			EJECUTIVO VARCHAR(50),
			SDO_OPE DECIMAL(30,6),
			VAR_SDO_DIA_ANT DECIMAL(30,6),
			SDO_PROM_ACUM DECIMAL(30,6),
			VAR_SDO_MES_ANT DECIMAL(30,6),
			VAR_SDO_PROM_DIA_ANT DECIMAL(30,6),
			VAR_SDO_PROM_MES_ANT DECIMAL(30,6),
			VAR_SDO_PROM_TRIM_ANT DECIMAL(30,6),
			VAR_SDO_OPE_TRIM_ANT DECIMAL(30,6),
			FCH_TRM_ANT INT,
			FCH_MES_ANT INT,
			FCH_DIA_ANT INT
)
CREATE UNIQUE
INDEX IDX_C_COL
ON  FTORREN.C_COL (ID_C_COL,FEC_PROC,REGION,PLATAFORMA,EJECUTIVO)
WITH ALLOW_DUP_ROW;

INSERT INTO FTORREN.C_COL(
			FEC_PROC,
			REGION,
		    PLATAFORMA,
			EJECUTIVO,
			SDO_OPE,
			VAR_SDO_DIA_ANT,
			SDO_PROM_ACUM,
			VAR_SDO_MES_ANT,
			VAR_SDO_PROM_DIA_ANT,
			VAR_SDO_PROM_MES_ANT,
			VAR_SDO_PROM_TRIM_ANT,
			VAR_SDO_OPE_TRIM_ANT,
			FCH_TRM_ANT,
			FCH_MES_ANT,
			FCH_DIA_ANT
)
SELECT
A.FEC_PROC,
A.REGION,
A.PLATAFORMA,
A.EJECUTIVO,
A.SDO_OPE,
A.VAR_SDO_DIA_ANT,
A.SDO_PROM_ACUM,
A.VAR_SDO_MES_ANT,
A.VAR_SDO_PROM_DIA_ANT,
A.VAR_SDO_PROM_MES_ANT,
A.VAR_SDO_PROM_TRIM_ANT,
A.VAR_SDO_OPE_TRIM_ANT,
CASE
WHEN QUARTER((CONVERT(DATETIME, CONVERT(CHAR(8), (A.FEC_PROC)))))-1 = 0 THEN 20171231-10000
WHEN QUARTER((CONVERT(DATETIME, CONVERT(CHAR(8), (A.FEC_PROC)))))-1 = 1 THEN 20170331
WHEN QUARTER((CONVERT(DATETIME, CONVERT(CHAR(8), (A.FEC_PROC)))))-1 = 2 THEN 20170630
WHEN QUARTER((CONVERT(DATETIME, CONVERT(CHAR(8), (A.FEC_PROC)))))-1 = 3 THEN 20170930
WHEN QUARTER((CONVERT(DATETIME, CONVERT(CHAR(8), (A.FEC_PROC)))))-1 = 4 THEN 20171231
END AS FCH_TRM_ANT,
CAST(CONVERT(VARCHAR(10),DATEADD(DD,-(DAY(CONVERT(DATETIME, CONVERT(CHAR(8), (A.FEC_PROC))))),CONVERT(DATETIME, CONVERT(CHAR(8), (A.FEC_PROC)))),112) AS INT) AS FCH_MES_ANT,
B.PRV_FEC_PROC AS FCH_DIA_ANT
FROM FTORREN.STOCK_VAR_DIA A
LEFT JOIN
(SELECT
(A.CAL_ANO*10000+A.CAL_MES*100+A.CAL_DIA) AS PRV_FEC_PROC,
CONVERT(DATETIME, CONVERT(CHAR(8), (A.CAL_ANO*10000+A.CAL_MES*100+A.CAL_DIA)))+(A.CAL_CTD_DIA+1) AS FEC_PROC,
CAST(CONVERT(CHAR, CONVERT(DATETIME, CONVERT(CHAR(8), (A.CAL_ANO*10000+A.CAL_MES*100+A.CAL_DIA)))+(A.CAL_CTD_DIA+1),112) AS INT) AS A_FEC_PROC,
A.CAL_CTD_DIA+1 AS CAL_CTD_DIA
FROM HISTORICA.CAL_DIA A
WHERE CAL_IND_DIA = 'H'
AND CAL_CTD_DIA <> 0) B
ON A.FEC_PROC = B.A_FEC_PROC


---------------------------------------------


SELECT
FEC_PROC,
ANO_MES,
LTRIM(RTRIM(EJE_CLI)) AS EJECUTIVO,
CASE
WHEN LTRIM(RTRIM(EJE_CLI))='CBUTTO' AND LTRIM(RTRIM(PLT_CLI_DESC))='PLATAFORMA1' THEN 'PLATAFORMACENTRAL'
WHEN LTRIM(RTRIM(EJE_CLI))='RFREYMA' AND LTRIM(RTRIM(PLT_CLI_DESC))='PLATAFORMACENTRAL' THEN 'PLATAFORMA10'
ELSE LTRIM(RTRIM(PLT_CLI_DESC))
END AS PLAT,
LTRIM(RTRIM(REG_CLI_DESC)) AS REG,
LTRIM(RTRIM(TIP_OPE_DESC)) AS TIPO_OPE,
LTRIM(RTRIM(BCA)) AS BCA,
SUM(SDO_OPE)/1000 AS SDO_M$,
SUM(SDO_PROM_ACUM)/1000 AS SDO_PROM_M$,
SUM(VAR_SDO_DIA_ANT)/1000 AS VAR_DIA_SDO_M$,
SUM(VAR_SDO_MES_ANT)/1000 AS VAR_MES_SDO_M$,
SUM(VAR_SDO_PROM_DIA_ANT)/1000 AS VAR_DIA_SDO_PROM_M$,
SUM(VAR_SDO_PROM_MES_ANT)/1000 AS VAR_MES_SDO_PROM_M$
FROM
SGC.STOCK_VAR_DIA
WHERE FEC_PROC > CAST(DATEFORMAT(DATEADD(MONTH,-13,NOW()),'YYYYMMDD') AS  INT)
AND LTRIM(RTRIM(BCA)) IN ('EM','EMQ')
AND RUT<>'76804710'))
AND REGION IS NOT NULL
AND PLATAFORMA IS NOT NULL
GROUP BY
FEC_PROC,
ANO_MES,
EJE_CLI,
PLT_CLI_DESC,
REG_CLI_DESC,
TIP_OPE_DESC,
BCA







