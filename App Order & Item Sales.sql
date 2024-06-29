SELECT 
	h.strWareHouseName as 'Outlet Name',
	h.strSalesOrderCode as 'Order Code',
	h.dteSalesOrderDate as 'Order Date',
	h.intSoldToPartnerId as 'Customer ID',
	h.strSoldToPartnerName as 'Customer Name',
	r.strItemCode as 'Item Code',
	r.strItemName as 'Item Name',
	r.numOrderQuantity as 'Item Qty',
	r.numItemPrice as 'MRP',
	r.numItemSalesPrice as 'Sales Price',
	r.numOrderQuantity * r.numItemSalesPrice as 'Total Sales Amount'

from [APON].[oms].[tblSalesOrderHeader] h 
  JOIN oms.tblSalesOrderRow r on h.intSalesOrderId=r.intSalesOrderId
  WHERE h.intWareHouseId=10221 AND  
  h.isActive=1 AND 
  h.dteSalesOrderDate>='2023-07-23' AND h.dteSalesOrderDate<=GETDATE()