SELECT
  inv.dteTransactionDate as 'Transaction Date',
  h.strDamageCode as 'Transaction Code',
  h.strTransactionType as 'Transaction Type',
  h.strWarehouse as 'Outlet Name',
  h.strManufacturer as 'Manufacturer',
  r.strItemCode as 'Item Code',
  r.strItemName as 'Item Name',
  r.numTransactionQuantity as 'Total Qty',
  r.monTransactionValue as 'Total Amount',
  r.isApproved as 'Approved',
  r.strReason as 'Reason'
FROM
  [APON].[wms].[tblDamageHeader] h
JOIN
  [APON].[wms].[tblDamageRow] r ON h.intDamageId = r.intDamageId
JOIN
  [APON].[wms].[tblInventoryTransactionHeader] inv ON h.intInventoryTransactionId = inv.intInventoryTransactionId
WHERE
  h.isActive = 1 AND
  r.isActive = 1 AND
  inv.dteTransactionDate BETWEEN '2024-02-01' AND GETDATE()
ORDER BY
  inv.dteTransactionDate DESC;




  SELECT
  inv.dteTransactionDate as 'Transaction Date',
  h.strDamageCode as 'Transaction Code',
  h.strTransactionType as 'Transaction Type',
  h.strWarehouse as 'Outlet Name',
  h.strManufacturer as 'Manufacturer',
  r.strItemCode as 'Item Code',
  r.strItemName as 'Item Name',
  r.numTransactionQuantity as 'Total Qty',
  r.monTransactionValue as 'Total Amount'
FROM
  [APON].[wms].[tblDamageHeader] h
JOIN
  [APON].[wms].[tblDamageRow] r ON h.intDamageId = r.intDamageId
JOIN
  [APON].[wms].[tblInventoryTransactionHeader] inv ON h.intInventoryTransactionId = inv.intInventoryTransactionId
WHERE
  h.isActive = 1 AND
  r.isActive = 1 AND
  inv.dteTransactionDate BETWEEN '2024-02-01' AND GETDATE()
ORDER BY
  inv.dteTransactionDate DESC;