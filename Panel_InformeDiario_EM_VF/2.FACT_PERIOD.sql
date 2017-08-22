DROP TABLE ftorren.FACT_PERIOD;

CREATE TABLE ftorren.FACT_PERIOD (
ID_PERIOD INT identity,
ANO_MES DECIMAL(15,0), 
REGION VARCHAR(50),
PLATAFORMA VARCHAR(50),
EJECUTIVO VARCHAR(50)
)
CREATE UNIQUE
INDEX IDX_FACT_PERIOD
ON  FTORREN.FACT_PERIOD (ANO_MES,REGION,PLATAFORMA,EJECUTIVO)
WITH ALLOW_DUP_ROW;

INSERT INTO ftorren.FACT_PERIOD(
ANO_MES,
REGION,
PLATAFORMA,
EJECUTIVO
)
SELECT
ANO_MES,
REGION,
PLATAFORMA,
EJECUTIVO
FROM ftorren.STOCK_VAR_DIA
WHERE REGION <> '' AND PLATAFORMA <> '' AND EJECUTIVO <> ''
GROUP BY ANO_MES,REGION,PLATAFORMA,EJECUTIVO
ORDER BY ANO_MES ASC;

SELECT * FROM ftorren.FACT_PERIOD;

