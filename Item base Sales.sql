SELECT 
  h.strWarehouseName AS Outlet,
  r.intItemId AS "ItemID",
  r.strItemCode AS "Item Code",
  r.strItemName AS "Item Name",
  i.strItemCategoryName AS "Item Category",
  i.strItemSubCategoryName AS "Item Sub Category",
  AVG(r.numMRP) AS MRP,
  AVG(r.numItemPrice) AS "Sales Price",
  SUM(numQuantity) AS "Total Quantity",
  SUM(r.numDeliveryValue) AS "Total Sales Amount",
  SUM(r.numTotalDiscountValue) AS "Total Discount"
  
FROM 
  [APON].[pos].[tblPosDeliveryRow] r
JOIN 
  [APON].[pos].[tblPosDeliveryHeader] h ON h.intDeliveryId = r.intDeliveryId
JOIN
	[APON].[itm].[tblItem] i ON r.intItemId = i.intItemId

WHERE 
  h.isActive = 1 
  AND r.isActive = 1 
  AND h.dteDeliveryDate BETWEEN '2024-05-01' AND GETDATE()
GROUP BY 
  h.strWarehouseName, 
  r.intItemId,
  r.strItemCode, 
  r.strItemName,
  i.strItemCategoryName,
  i.strItemSubCategoryName
ORDER BY 
  h.strWarehouseName,
  r.strItemCode;
