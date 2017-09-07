DROP TABLE FTORREN.CLIENTES_ACTIVOS_POR_SALDO;

CREATE TABLE FTORREN.CLIENTES_ACTIVOS_POR_SALDO (
ID_CAPS INT IDENTITY,
RUT INT,
ANO_MES INT,
SALDOP DECIMAL(20,6)
)
CREATE UNIQUE
INDEX IDX_CLIENTES_ACTIVOS_POR_SALDO
ON  FTORREN.CLIENTES_ACTIVOS_POR_SALDO (ID_CAPS,RUT)
WITH ALLOW_DUP_ROW;

INSERT INTO FTORREN.CLIENTES_ACTIVOS_POR_SALDO(
RUT,
ANO_MES,
SALDOP
)
SELECT 
B.RUT, 
A.ANO_MES, 
A.SALDOP  
FROM DBA.MARGEN A, DBA.CLI_AWK B
WHERE A.ANO_MES IN (201706, 201606)
AND LTRIM(RTRIM(A.CLI)) = LTRIM(RTRIM(B.CLIENTE))
AND A.ANO_MES = B.ANO_MES
AND LTRIM(RTRIM(A.LINEA)) IN (
'42A',
'42B',
'42C',
'42D',
'42E',
'45A',
'45D',
'58', 
'58B',
'58C',
'58D',
'58E',
'58F',
'58G')
AND A.SALDOP >= 193332
AND A.CLI <> 'CLI_X'



DROP TABLE FTORREN.RESUMEN_BALANCE;

CREATE TABLE FTORREN.RESUMEN_BALANCE (
ID_RESUMEN_BALANCE INT IDENTITY,
ANO_MES INT,
RUT INT,
IND_BALANCE VARCHAR(10)
)
CREATE UNIQUE
INDEX IDX_RESUMEN_BALANCE
ON  FTORREN.RESUMEN_BALANCE (ID_RESUMEN_BALANCE,RUT)
WITH ALLOW_DUP_ROW;

CREATE INDEX IDX_AM_RUT_RB ON  FTORREN.RESUMEN_BALANCE (ANO_MES,RUT);

INSERT INTO FTORREN.RESUMEN_BALANCE(
ANO_MES,
RUT,
IND_BALANCE
)
SELECT
ANO_MES,
RUT,
'X' AS IND_BALANCE
FROM FTORREN.CLIENTES_ACTIVOS_POR_SALDO
