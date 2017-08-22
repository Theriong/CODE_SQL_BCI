--PRIMERA CARGA
DROP TABLE ftorren.STOCK_VAR_DIA;

CREATE TABLE ftorren.STOCK_VAR_DIA (
			ID_C_COL INT identity,
			FEC_PROC DECIMAL(15,0), 
			ANO_MES DECIMAL(15,0), 
			REGION VARCHAR(50),
		    PLATAFORMA VARCHAR(50),
			EJECUTIVO VARCHAR(50),
			SDO_OPE DECIMAL(30),
			VAR_SDO_DIA_ANT DECIMAL(30),
			SDO_PROM_ACUM DECIMAL(30),
			VAR_SDO_MES_ANT DECIMAL(30),
			VAR_SDO_PROM_DIA_ANT DECIMAL(30),
			VAR_SDO_PROM_MES_ANT DECIMAL(30)
)
CREATE UNIQUE
INDEX IDX_STOCK_VAR_DIA
ON  ftorren.STOCK_VAR_DIA (ID_C_COL,ANO_MES,REGION,PLATAFORMA,EJECUTIVO)
WITH ALLOW_DUP_ROW;

INSERT INTO ftorren.STOCK_VAR_DIA(
			FEC_PROC,
			ANO_MES,
			REGION,
		    PLATAFORMA,
			EJECUTIVO,
			SDO_OPE,
			VAR_SDO_DIA_ANT,
			SDO_PROM_ACUM,
			VAR_SDO_MES_ANT,
			VAR_SDO_PROM_DIA_ANT,
			VAR_SDO_PROM_MES_ANT
)
		SELECT
			FEC_PROC,
			ANO_MES,
			TRIM(REG_CLI_DESC) AS REGION,
			CASE
			WHEN TRIM(PLT_CLI_DESC)= 'CBUTTO'
			AND TRIM(PLT_CLI_DESC)= 'PLATAFORMA 1' THEN 'PLATAFORMA CENTRAL'
			WHEN TRIM(PLT_CLI_DESC)= 'RFREYMA'
			AND TRIM(PLT_CLI_DESC)= 'PLATAFORMA CENTRAL' THEN 'PLATAFORMA 10'
			ELSE TRIM(PLT_CLI_DESC)
			END PLATAFORMA,
			TRIM(EJE_CLI) AS EJECUTIVO,
			SDO_OPE,
			VAR_SDO_DIA_ANT,
			SDO_PROM_ACUM,
			VAR_SDO_MES_ANT,
			VAR_SDO_PROM_DIA_ANT,
			VAR_SDO_PROM_MES_ANT
		FROM
			SGC.STOCK_VAR_DIA
	WHERE FEC_PROC > CAST(DATEFORMAT(DATEADD(MONTH,-12,NOW()),'YYYYMMDD') AS INT)				
	AND TRIM(BCA) IN ('EM','EMQ')				
	AND RUT<>'76804710'
 	AND REG_CLI_DESC<>''
 	AND PLT_CLI_DESC<>'';