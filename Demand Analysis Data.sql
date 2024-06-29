SELECT 
  h.strWarehouseName as Outlet, 
  r.strItemCode as "Item Code", 
  r.strItemName as "Item Name", 
  SUM(numQuantity) as "Total Quantity", 
  SUM(r.numDeliveryValue) as "Total Sales Amount",
  DATENAME(mm,h.dteDeliveryDate) as Month

FROM 
  [APON].[pos].[tblPosDeliveryRow] r
JOIN 
  [APON].[pos].[tblPosDeliveryHeader] h ON h.intDeliveryId = r.intDeliveryId
JOIN
	[APON].[itm].[tblItem] i ON r.intItemId = i.intItemId
WHERE 
  h.dteDeliveryDate between '2023-06-01' 
  and '2024-02-19'  
  AND h.isActive = 1 
  AND r.isActive = 1

GROUP BY
h.strWarehouseName,
DATENAME(mm,h.dteDeliveryDate),
r.strItemCode,
r.strItemName

ORDER BY
h.strWarehouseName