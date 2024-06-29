SELECT
	o.strWarehouseName as "Outlet",
	bp.strBusinessPartnerCode as "APON Code",
	bp.strBusinessPartnerName as "Name",
	cinfo.intEmployeeId as "HR Code",
	SUM(r.numDeliveryValue) as "Total Sales Amount",
	bp.isActive
  FROM [APON].[prt].[tblBusinessPartner] bp
	LEFT JOIN [APON].[dbo].[CustomerAdditionalInformation] cinfo on bp.intBusinessPartnerId = cinfo.intCustomerId
	LEFT JOIN [APON].[prt].[tblFactoryUnit] as f on cinfo.intFactoryId=f.intFactoryId
	LEFT JOIN [APON].[wms].[tblWarehouse] as o on f.intWarehouseId=o.intWarehouseId
	LEFT JOIN [APON].[pos].[tblPosDeliveryHeader] h on bp.strBusinessPartnerCode = h.strSoldToPartnerCode
	LEFT JOIN [APON].[pos].[tblPosDeliveryRow] r on h.intDeliveryId = r.intDeliveryId

WHERE 
	--bp.isActive = 1 AND
	bp.strPartnerSalesType = 'Customer' AND
	--o.strWarehouseName = 'Interstoff Apparels Ltd.' AND
	o.strWarehouseName IS NOT NULL 

GROUP BY
	o.strWarehouseName,
	bp.intBusinessPartnerId,
	bp.strBusinessPartnerCode,
	bp.strBusinessPartnerName,
	cinfo.intEmployeeId,
	bp.numDistributorCreditLimit,
	bp.isActive

HAVING
	SUM(r.numDeliveryValue) > 0
ORDER BY
	bp.intBusinessPartnerId
