--PERMISOS DE ACCESO A TABLA
GRANT SELECT
     ON EDW_TEMPUSU.PRV_BTX TO skataok;
     
     
--COLUMNA AUTOINCREMENT 
CREATE TABLE EDW_TEMPUSU.FTN (
rec_num INTEGER GENERATED ALWAYS AS IDENTITY
(START WITH 1 
INCREMENT BY 1 
MINVALUE -2147483647 
MAXVALUE 2147483647 
NO CYCLE),
col2 VARCHAR(15)
)


--CREAR TABLA A PARTIR DE OTRA
CREATE TABLE EDW_TEMPUSU.EVENT_CARD_TRJ AS
(
    SELECT * FROM EDW_VW.EVENT_CARD_TRJ
)
WITH NO DATA;

--OBTIENE CAMPOS DE UNA TABLA + INFO
show select * from EDW_VW.BCI_CHANNEL_TYPE;