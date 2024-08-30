select  t.intWarehouseId as outlet,
 t.intItemId as Item_code,
 i.strItemName,   
 i.strItemBarcode 
 
from tblInventoryRecordForSales as t
left join 
    itm.tblItem as i 
    on 
    t.intItemId = i.intItemId 

WHERE
t.isAvailable = 1


--tblInventoryTransactionRow
