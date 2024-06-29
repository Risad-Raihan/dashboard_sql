SELECT 
  h.strWarehouseName as Outlet,
  --r.strItemCode as "Item Code", 
  --r.strItemName as "Item Name",
  i.strItemSubCategoryName AS "Item Sub Category",
  DATENAME(MONTH,h.dteDeliveryDate) as "Month",
  DATENAME(YEAR,h.dteDeliveryDate) as "Year",
  SUM(numQuantity) AS "Total Quantity",
  SUM(r.numDeliveryValue) AS "Total Sales Amount"
  
FROM 
  [APON].[pos].[tblPosDeliveryRow] r
JOIN 
  [APON].[pos].[tblPosDeliveryHeader] h ON h.intDeliveryId = r.intDeliveryId
JOIN 
  [APON].[itm].[tblItem] i ON r.intItemId = i.intItemId
WHERE 
  h.isActive = 1 
  AND r.isActive = 1 
  AND h.dteDeliveryDate BETWEEN '2022-01-01' AND GETDATE()
GROUP BY
  DATENAME(MONTH,h.dteDeliveryDate),
  DATENAME(YEAR,h.dteDeliveryDate),
  h.strWarehouseName,
  i.strItemSubCategoryName
ORDER BY
DATENAME(MONTH,h.dteDeliveryDate),
DATENAME(YEAR,h.dteDeliveryDate);