SELECT 
  h.strWarehouseName as Outlet, 
  h.strDeliveryCode as Challan, 
  --TRIM(REPLACE(SUBSTRING(h.strSoldToPartnerName, 1, CHARINDEX('[', h.strSoldToPartnerName) - 1), '''', '')) as "Customer Name",
  h.strSoldToPartnerCode as "Customer Code",
  h.strSoldToPartnerName as "Customer Name",
  --LEFT(REPLACE(REPLACE(SUBSTRING(h.strSoldToPartnerName, CHARINDEX('[', h.strSoldToPartnerName), CHARINDEX(']', h.strSoldToPartnerName) - CHARINDEX('[', h.strSoldToPartnerName) + 1), '[', ''), ']', ''), LEN(REPLACE(REPLACE(SUBSTRING(h.strSoldToPartnerName, CHARINDEX('[', h.strSoldToPartnerName), CHARINDEX(']', h.strSoldToPartnerName) - CHARINDEX('[', h.strSoldToPartnerName) + 1), '[', ''), ']', '')) - 1) as "HR Code",
  h.dteDeliveryDate as Date, 
  r.strItemCode as "Item Code", 
  r.strItemName as "Item Name", 
  numQuantity as "Total Quantity", 
  r.numMRP as MRP, 
  r.numItemPrice as "Sales Price", 
  r.numDeliveryValue as "Total Sales Amount", 
  r.numTotalDiscountValue as "Total Discount", 
  r.numCogs as COGS 
FROM 
  [APON].[pos].[tblPosDeliveryHeader] h 
  join [APON].[pos].[tblPosDeliveryRow] r on h.intDeliveryId = r.intDeliveryId 
where 
  h.isActive = 1 
  and r.isActive = 1 
  and h.dteDeliveryDate between '2024-1-1' 
  and GETDATE()
order by 
  h.dteDeliveryDate DESC;