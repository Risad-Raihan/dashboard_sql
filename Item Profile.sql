SELECT 
  i.intItemId as ItemId, 
  i.strItemCode as 'Item Code', 
  i.strItemName as 'Item Name', 
  i.strItemCategoryName as 'Item Category', 
  i.strItemSubCategoryName as 'Item Sub Category',  
  m.strName as 'Manufacturer',
  i.strItemTypeName as 'Item Type'
FROM 
  [APON].[itm].[tblItem] i 
  JOIN APON.dbo.Manufacture m on i.intManufactureId = m.intId
WHERE 
  strItemTypeName = 'Trading Goods' 
  AND i.isActive = 1
order by
i.intItemId DESC


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
  SUM(r.numTotalDiscountValue) AS "Total Discount",
  CASE
    WHEN  i.strItemSubCategoryName IN ('Baby Food', 'Baby Oral Care', 'Baby Shampoo', 'Baby Soap', 'Baby Powder', 'Baby Lotion', 'Baby Cream', 'Baby Oil', 'Baby Hair Oil', 'Baby Diapers') THEN 'Baby Essentials'
    WHEN  i.strItemSubCategoryName IN ('Bathroom Cleaner', 'Floor Cleaner', 'Glass Cleaner') THEN 'Cleaning Item'
    WHEN  i.strItemSubCategoryName IN ('Dal', 'Flour', 'Mustard Oil', 'Salt', 'Sugar', 'Chinigura Rice', 'Spices', 'Cooking Essentials', 'Condensed Milk', 'Whole Spice', 'Rice Bran Oil') THEN 'Commodities'
    WHEN  i.strItemSubCategoryName IN ('Milk Powder', 'UHT Milk', 'Ghee') THEN 'Dairy'
    WHEN  i.strItemSubCategoryName IN ('Egg', 'Fruits', 'Fish', 'Meat', 'Vegetables') THEN 'Perishable'
    WHEN  i.strItemSubCategoryName IN ('Rice') THEN 'Rice'
    WHEN  i.strItemSubCategoryName IN ('Tiffin Item -1', 'Tiffin Item -2', 'Noodles', 'Non-Fried Snack', 'Home-made Snacks', 'Family Pack', 'Combo Pack', 'Beverages', 'Water', 'Sweets', 'Soup', 'Soft Drink Powder', 'Breakfast', 'Shemai') THEN 'Snacks'
    WHEN  i.strItemSubCategoryName IN ('Soybean Oil') THEN 'Soybean Oil'
    WHEN  i.strItemSubCategoryName IN ('Bath Soap', 'Oral Care', 'Shampoo', 'Dish Wash', 'Face Cream', 'Hair Oil', 'Facewash', 'Body Spray', 'Body Powder', 'Handwash', 'Hair Remover', 'Personal Care', 'Petroleum Jelly', 'Body Wash', 'Shaving Item', 'Nail Polish', 'Body Lotion', 'Glycerin', 'Nail Polish Remover', 'Basket', 'Body Oil', 'Face wash') THEN 'Toiletries'
    ELSE 'Others'
  END AS 'Big Block'
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
	  h.strWarehouseName,
	  h.dteDeliveryDate,
	  r.intItemId,
	  r.strItemCode, 
	  r.strItemName,
	  i.strItemCategoryName,
	  i.strItemSubCategoryName	




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
  SUM(r.numTotalDiscountValue) AS "Total Discount",
  CASE
    WHEN  i.strItemSubCategoryName IN ('Baby Food', 'Baby Oral Care', 'Baby Shampoo', 'Baby Soap', 'Baby Powder', 'Baby Lotion', 'Baby Cream', 'Baby Oil', 'Baby Hair Oil', 'Baby Diapers') THEN 'Baby Essentials'
    WHEN  i.strItemSubCategoryName IN ('Bathroom Cleaner', 'Floor Cleaner', 'Glass Cleaner') THEN 'Cleaning Item'
    WHEN  i.strItemSubCategoryName IN ('Dal', 'Flour', 'Mustard Oil', 'Salt', 'Sugar', 'Chinigura Rice', 'Spices', 'Cooking Essentials', 'Condensed Milk', 'Whole Spice', 'Rice Bran Oil') THEN 'Commodities'
    WHEN  i.strItemSubCategoryName IN ('Milk Powder', 'UHT Milk', 'Ghee') THEN 'Dairy'
    WHEN  i.strItemSubCategoryName IN ('Egg', 'Fruits', 'Fish', 'Meat', 'Vegetables') THEN 'Perishable'
    WHEN  i.strItemSubCategoryName IN ('Rice') THEN 'Rice'
    WHEN  i.strItemSubCategoryName IN ('Tiffin Item -1', 'Tiffin Item -2', 'Noodles', 'Non-Fried Snack', 'Home-made Snacks', 'Family Pack', 'Combo Pack', 'Beverages', 'Water', 'Sweets', 'Soup', 'Soft Drink Powder', 'Breakfast', 'Shemai') THEN 'Snacks'
    WHEN  i.strItemSubCategoryName IN ('Soybean Oil') THEN 'Soybean Oil'
    WHEN  i.strItemSubCategoryName IN ('Bath Soap', 'Oral Care', 'Shampoo', 'Dish Wash', 'Face Cream', 'Hair Oil', 'Facewash', 'Body Spray', 'Body Powder', 'Handwash', 'Hair Remover', 'Personal Care', 'Petroleum Jelly', 'Body Wash', 'Shaving Item', 'Nail Polish', 'Body Lotion', 'Glycerin', 'Nail Polish Remover', 'Basket', 'Body Oil', 'Face wash') THEN 'Toiletries'
    ELSE 'Others'
  END AS 'Big Block'
FROM 
  [APON].[pos].[tblPosDeliveryRow] r
JOIN 
  [APON].[pos].[tblPosDeliveryHeader] h ON h.intDeliveryId = r.intDeliveryId
JOIN
  [APON].[itm].[tblItem] i ON r.intItemId = i.intItemId
WHERE 
  h.isActive = 1 
  AND r.isActive = 1 
  AND h.dteDeliveryDate BETWEEN '2023-10-01' AND GETDATE()

GROUP BY 
	  h.strWarehouseName,
	  h.dteDeliveryDate,
	  r.intItemId,
	  r.strItemCode, 
	  r.strItemName,
	  i.strItemCategoryName,
	  i.strItemSubCategoryName	