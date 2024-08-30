SELECT  
t.[intItemId]
      ,t.[strItemName]
    
      ,t.[isActive],
      i.strItemBarcode
      
  FROM [APON].[wms].[tblInventoryTransactionRow] as t
  left JOIN
            itm.tblItem as i 
            on 
            t.intItemId = i.intItemId
  where 
  strInventoryStockTypeName = 'Open Stock' and
  strInventoryLocationName = 'Trading Goods Stock' and
   t.isActive = 1
   --strItemName != '%Demo %'
group by 
t.[intItemId]
      ,t.[strItemName]
    
      ,t.[isActive],
      i.strItemBarcode