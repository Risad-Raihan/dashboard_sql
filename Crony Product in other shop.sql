SELECT 
  h.strWarehouseName as Outlet, 
  r.strItemCode as "Item Code", 
  r.strItemName as "Item Name",
  SUM(numQuantity) as "Total Quantity", 
  SUM(r.numItemPrice * numQuantity) as "Total Sales Amount", 
  SUM(r.numTotalDiscountValue) as "Total Discount", 
  AVG(r.numCogs) as COGS 
FROM 
  [APON].[pos].[tblPosDeliveryRow] r
JOIN 
  [APON].[pos].[tblPosDeliveryHeader] h ON h.intDeliveryId = r.intDeliveryId
WHERE 
  h.isActive = 1 
  AND r.isActive = 1 
  AND h.dteDeliveryDate BETWEEN '2023-03-01' AND GETDATE()
  AND r.strItemCode IN(
    SELECT 
	  r.strItemCode as "Item Code"
	FROM 
	  [APON].[pos].[tblPosDeliveryRow] r
	JOIN 
	  [APON].[pos].[tblPosDeliveryHeader] h ON h.intDeliveryId = r.intDeliveryId
	WHERE 
	  h.isActive = 1 
	  AND r.isActive = 1 
	  AND h.strWarehouseName = 'Crony Tex Sweater Ltd.'
	  AND h.dteDeliveryDate BETWEEN '2023-03-01' AND GETDATE()
  )
GROUP BY 
  h.strWarehouseName, 
  r.strItemCode, 
  r.strItemName
ORDER BY 
  h.strWarehouseName,
  r.strItemCode;


