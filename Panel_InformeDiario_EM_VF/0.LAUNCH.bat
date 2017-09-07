@ECHO OFF

REM COPY all

SET ruta=U:\Users\ftorren\Documents\Github\CODE_SQL_BCI\Panel_InformeDiario_EM_VF\

dbisql -c "DSN=Sumika-32" %ruta%\1.STOCK_VAR_DIA.sql
IF %ERRORLEVEL% NEQ 0 GOTO ERROR_HANDLER

dbisql -c "DSN=Sumika-32" %ruta%\2.FACT_PERIOD.sql
IF %ERRORLEVEL% NEQ 0 GOTO ERROR_HANDLER

dbisql -c "DSN=Sumika-32" %ruta%\3.C_COL.sql
IF %ERRORLEVEL% NEQ 0 GOTO ERROR_HANDLER

dbisql -c "DSN=Sumika-32" %ruta%\4.TMP_C_PPTO.sql
IF %ERRORLEVEL% NEQ 0 GOTO ERROR_HANDLER

dbisql -c "DSN=Sumika-32" %ruta%\5.C_PPTO.sql
IF %ERRORLEVEL% NEQ 0 GOTO ERROR_HANDLER

dbisql -c "DSN=Sumika-32" %ruta%\6.FCH_PERIOD.sql
IF %ERRORLEVEL% NEQ 0 GOTO ERROR_HANDLER

dbisql -c "DSN=Sumika-32" %ruta%\7.DET_DIA_EMP_VTA.sql
IF %ERRORLEVEL% NEQ 0 GOTO ERROR_HANDLER

dbisql -c "DSN=Sumika-32" %ruta%\8.SDO_PROM.sql
IF %ERRORLEVEL% NEQ 0 GOTO ERROR_HANDLER

dbisql -c "DSN=Sumika-32" %ruta%\9.C_DVN.sql
IF %ERRORLEVEL% NEQ 0 GOTO ERROR_HANDLER

echo.
echo Sucess!!!
GOTO QUIT

:ERROR_HANDLER
echo.
echo Error occured!!!
exit 1

:QUIT
echo.