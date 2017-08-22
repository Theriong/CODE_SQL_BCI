select COD_BCO_SBIF,DESC_BCO_SBIF,COD_BCO_INTERNAL,DESC_BCO_INTERNAL,COD_TRX,DESC_TRX,SUM(MONTO),COUNT(*) as TRANSACCIONES
from EDW_TEMPUSU.PRV_BTX
--WHERE COD_BCO_SBIF = 31
GROUP by COD_BCO_SBIF,DESC_BCO_SBIF,COD_BCO_INTERNAL,DESC_BCO_INTERNAL,COD_TRX,DESC_TRX
ORDER BY COD_BCO_INTERNAL


SELECT 
A.COD_BCO_INTERNAL, 
A.DESC_BCO_INTERNAL,
A.TOTAL_TRX,
B.TOTAL_TRX AS TOTAL_CONSULTAS,
(A.TOTAL_TRX-B.TOTAL_TRX) AS OTRAS
FROM
(
SELECT COD_BCO_INTERNAL, DESC_BCO_INTERNAL, SUM(CANT_TRX) as TOTAL_TRX FROM EDW_TEMPUSU.PRV_BTX_RESUMEN
GROUP BY COD_BCO_INTERNAL, DESC_BCO_INTERNAL
) A
INNER JOIN
(
SELECT COD_BCO_INTERNAL, DESC_BCO_INTERNAL, SUM(CANT_TRX) as TOTAL_TRX FROM EDW_TEMPUSU.PRV_BTX_RESUMEN
WHERE DESC_TRX LIKE '%CONSULTA%'
GROUP BY COD_BCO_INTERNAL, DESC_BCO_INTERNAL
) B
ON A.COD_BCO_INTERNAL = B.COD_BCO_INTERNAL




SELECT * FROM EDW_TEMPUSU.PRV_BTX