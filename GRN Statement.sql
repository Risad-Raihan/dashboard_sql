select 
h.strInventoryTransactionCode as 'Inventory Transaction Code',
h.dteTransactionDate as 'Transaction Date',
h.strReferenceCode as 'Reference Code',
h.strBusinessPartnerName as 'Business Partner Name',
h.strComments as 'Remarks',
r.intItemId as 'Item Id',
i.strItemCode as 'Item Code',
r.strItemName as 'Item Name',
r.strUoMName as 'UoM Name',
h.strWarehouseName as 'Warehouse Name',
m.strName as 'Manufacturer Name',
r.numTransactionQuantity as 'Transaction Quantity',
r.monTransactionValue as 'Transaction Value',
r.numVatAmount as 'VAT',
r.dteExpiredDate as 'Expired Date',
s.monRate as 'Rate',
s.monSalesRate as 'Sales Rate',
s.monMRP as 'MRP'

from [APON].[wms].[tblInventoryTransactionHeader] h
join [APON].[wms].[tblInventoryTransactionRow] r on h.intInventoryTransactionId = r.intInventoryTransactionId
join [APON].[dbo].[tblInventoryRecordForSales] s on h.intInventoryTransactionId = s.intInventoryReference and r.intItemId = s.intItemId
join [APON].[itm].[tblItem] i on r.intItemId = i.intItemId
join [APON].[dbo].[Manufacture] m on i.intManufactureId = m.intId

where 
h.TransactionGroupId = 1 and
h.intTransactionTypeId = 1 and
h.isActive = 1 and
r.isActive = 1 and
i.strItemTypeName = 'Trading Goods' and
h.dteTransactionDate between '2023-01-01' 
  and GETDATE()
  
order by 
h.intInventoryTransactionId