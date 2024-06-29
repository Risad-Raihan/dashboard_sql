SELECT
	itr.strInventoryTransactionCode as TransactionCode,
	ith.strReferenceCode as ReferenceCode,
	ith.dteTransactionDate,
	ith.strWarehouseName,
	itr.strItemName,
	itr.numTransactionQuantity,
	itr.monTransactionValue,
	ith.strTransactionTypeName


FROM 
  APON.wms.tblInventoryTransactionRow itr 
  JOIN APON.wms.tblInventoryTransactionHeader ith ON itr.intInventoryTransactionId = ith.intInventoryTransactionId 

where dteTransactionDate between '2023-01-01' 
  and GETDATE() 
  and intTransactionTypeId = 19 --Transfer Out and 4 is Tranfer In

order by
dteTransactionDate