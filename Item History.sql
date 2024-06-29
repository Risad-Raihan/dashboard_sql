select
	dteTransactionDate as 'Date',
	ith.strWarehouseName as 'Outlet',
	--i.strItemCode as 'Item Code',
	itr.strItemName as 'Item',
	strTransactionTypeName 'Transaction Type',
	SUM(numTransactionQuantity) 'Transaction QTY',
	SUM(monTransactionValue) 'Transaction Value'


FROM
	[APON].[wms].[tblInventoryTransactionRow] itr 
  JOIN [APON].[wms].[tblInventoryTransactionHeader] ith ON itr.intInventoryTransactionId = ith.intInventoryTransactionId
  JOIN [APON].[itm].[tblItem] i on itr.intItemId = i.intItemId

where 
i.strItemCode = 15554051 AND
ith.strWarehouseName = 'Saturn Textiles Ltd.' 
--ith.dteTransactionDate between '2023-10-01' 
  --and GETDATE()

GROUP BY
dteTransactionDate,
ith.strWarehouseName,
i.strItemCode,
itr.strItemName,
strTransactionTypeName

order by
dteTransactionDate 