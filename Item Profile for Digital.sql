SELECT 
  i.intItemId as ItemId, 
  i.strItemCode as 'Item Code', 
  i.strItemName as 'Item Name',
  i.strItemBanglaName as 'Item Bangla Name',
  i.strItemCategoryName as 'Item Category', 
  i.strItemSubCategoryName as 'Item Sub Category', 
  i.imagePath as 'Image',
  i.strItemTypeName as 'Type',
  i.isActive, 
  i.intManufactureId 
FROM 
  [APON].[itm].[tblItem] i 
WHERE 
  strItemTypeName = 'Trading Goods' 
  AND i.isActive = 1