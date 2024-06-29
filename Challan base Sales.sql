SELECT 
  h.strWarehouseName as Outlet, 
  h.strDeliveryCode as Challan,  
  --TRIM(REPLACE(SUBSTRING(h.strSoldToPartnerName, 1, CHARINDEX('[', h.strSoldToPartnerName) - 1), '''', '')) as "Customer Name",
  h.strSoldToPartnerCode as "Customer Code",
  h.strSoldToPartnerName as "Customer Name",
  --LEFT(REPLACE(REPLACE(SUBSTRING(h.strSoldToPartnerName, CHARINDEX('[', h.strSoldToPartnerName), CHARINDEX(']', h.strSoldToPartnerName) - CHARINDEX('[', h.strSoldToPartnerName) + 1), '[', ''), ']', ''), LEN(REPLACE(REPLACE(SUBSTRING(h.strSoldToPartnerName, CHARINDEX('[', h.strSoldToPartnerName), CHARINDEX(']', h.strSoldToPartnerName) - CHARINDEX('[', h.strSoldToPartnerName) + 1), '[', ''), ']', '')) - 1) as "HR Code",
  h.dteDeliveryDate as Date,  
  SUM(r.numQuantity) as "Total Quantity",
  SUM(r.numMRP) as MRP,
  SUM(r.numItemPrice) as "Sales Price",
  SUM(r.numDeliveryValue) as "Total Sales Amount", 
  SUM(r.numTotalDiscountValue) as "Total Discount",
  SUM(r.numCogs) as COGS,
  h.numCashAmount as "Cash Amount",
  h.numCreditAmount as "Credit Amount",
  h.numCardAmount as "Card Amount",
  h.numMFSAmount as "MFS Amount"
FROM 
  [APON].[pos].[tblPosDeliveryHeader] h
  JOIN [APON].[pos].[tblPosDeliveryRow] r on h.intDeliveryId = r.intDeliveryId
WHERE 
  h.isActive = 1 
  AND r.isActive = 1 
  AND h.dteDeliveryDate BETWEEN '2023-05-01' AND GETDATE()
GROUP BY 
  h.intWarehouseId,
  h.strWarehouseName,
  h.strDeliveryCode,
  h.strSoldToPartnerName,
  h.strSoldToPartnerCode,
  h.dteDeliveryDate,
  h.numCashAmount,
  h.numCreditAmount,
  h.numCardAmount,
  h.numMFSAmount
ORDER BY 
  h.intWarehouseId,
  h.dteDeliveryDate;