SELECT 
  h.strWarehouseName as Outlet, 
  h.strDeliveryCode as Challan, 
  h.strSoldToPartnerCode as "Customer Code",
  h.strSoldToPartnerName as "Customer Name",
  h.dteDeliveryDate as Date, 
  r.strItemCode as "Item Code", 
  r.strItemName as "Item Name", 
  numQuantity as "Total Quantity", 
  r.numMRP as MRP, 
  r.numItemPrice as "Sales Price", 
  r.numDeliveryValue as "Total Sales Amount", 
  r.numTotalDiscountValue as "Total Discount" , 
  r.numCOGS as COGS,
  (
    CASE WHEN itr.numTransactionQuantity = 0 THEN 1 ELSE itr.monTransactionValue / itr.numTransactionQuantity END
  ) NewCOGS 
FROM 
  wms.tblInventoryTransactionRow itr 
  JOIN wms.tblInventoryTransactionHeader ith ON itr.intInventoryTransactionId = ith.intInventoryTransactionId 
  JOIN pos.tblPosDeliveryHeader h ON ith.intReferenceId = h.intDeliveryId 
  AND ith.strReferenceCode = h.strDeliveryCode 
  JOIN pos.tblPosDeliveryRow r ON h.intDeliveryId = r.intDeliveryId 
  AND itr.intItemId = r.intItemId 
WHERE 
  ith.intReferenceTypeId = 8 
  and h.dteDeliveryDate between '2024-01-01' 
  and '2024-01-31'
  AND ith.isActive = 1 
  AND h.isActive = 1 
  AND itr.isActive = 1 
  AND r.isActive = 1



 SELECT 
  h.strWarehouseName as Outlet, 
  h.strDeliveryCode as Challan, 
  h.strSoldToPartnerCode as "Customer Code",
  h.strSoldToPartnerName as "Customer Name",
  h.dteDeliveryDate as Date, 
  r.strItemCode as "Item Code", 
  r.strItemName as "Item Name", 
  numQuantity as "Total Quantity", 
  r.numMRP as MRP, 
  r.numItemPrice as "Sales Price", 
  r.numDeliveryValue as "Total Sales Amount", 
  r.numTotalDiscountValue as "Total Discount" , 
  r.numCOGS as COGS,
  (
    CASE WHEN itr.numTransactionQuantity = 0 THEN 1 ELSE itr.monTransactionValue / itr.numTransactionQuantity END
  ) NewCOGS 
FROM 
  wms.tblInventoryTransactionRow itr 
  JOIN wms.tblInventoryTransactionHeader ith ON itr.intInventoryTransactionId = ith.intInventoryTransactionId 
  JOIN pos.tblPosDeliveryHeader h ON ith.intReferenceId = h.intDeliveryId 
  AND ith.strReferenceCode = h.strDeliveryCode 
  JOIN pos.tblPosDeliveryRow r ON h.intDeliveryId = r.intDeliveryId 
  AND itr.intItemId = r.intItemId 
WHERE 
  ith.intReferenceTypeId = 8 
  and h.dteDeliveryDate between '2024-03-01' 
  and GETDATE() 
  AND ith.isActive = 1 
  AND h.isActive = 1 
  AND itr.isActive = 1 
  AND r.isActive = 1



