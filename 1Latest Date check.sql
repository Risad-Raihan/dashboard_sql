SELECT TOP 1
  h.dteDeliveryDate as LatestDate
FROM 
  [APON].[pos].[tblPosDeliveryHeader] h 
WHERE 
  h.isActive = 1 
ORDER BY 
  h.dteDeliveryDate DESC;