select
h.strPurchaseOrderNo as 'PO No',
h.strWarehouseName as 'Outlet',
h.dtePurchaseOrderDate as 'PO Date',
h.dteLastShipmentDate as 'Required Delivery Date',
h.strBusinessPartnerName as 'Supplier',
--i.strItemCode as 'Item Code',
--i.strItemName as 'Item Name',
m.strName as 'Manufacturer Name',
SUM(r.numOrderQty) as 'Order Qty',
SUM(r.numTotalGrossAmount) as 'Order Amount'


from APON.pro.tblPurchaseOrderHeader h
JOIN APON.pro.tblPurchaseOrderRow r on h.intPurchaseOrderId=r.intPurchaseOrderId
join [APON].[itm].[tblItem] i on r.intItemId = i.intItemId
join [APON].[dbo].[Manufacture] m on i.intManufactureId = m.intId

where h.isActive = 1 and
r.isActive = 1 and
h.isApproved = 1 and
h.dtePurchaseOrderDate between '2023-09-25'
  and GETDATE()

GROUP BY
h.intPurchaseOrderId,
h.strPurchaseOrderNo,
h.strWarehouseName,
h.dtePurchaseOrderDate,
h.dteLastShipmentDate,
h.strBusinessPartnerName,
m.strName

ORDER BY
h.intPurchaseOrderId