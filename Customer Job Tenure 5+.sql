SELECT
	o.strWarehouseName as "Outlet",
	bp.strBusinessPartnerCode as "APON Code",
	bp.strBusinessPartnerName as "Name",
	cinfo.intEmployeeId as 'HR Code',
	bp.strContactNumber as "Contact Number",
	cinfo.strDepartment as 'Department',
	cinfo.strDesignation as 'Designation',
	cinfo.dteJoiningDate as 'Joining Date',
	cinfo.monGrossSalary as 'Gross Salary',
	SUM(r.numItemPrice * r.numQuantity) AS "Total Sales Amount"

  FROM [APON].[prt].[tblBusinessPartner] bp
	LEFT JOIN [APON].[dbo].[CustomerAdditionalInformation] cinfo on bp.intBusinessPartnerId = cinfo.intCustomerId
	LEFT JOIN [APON].[prt].[tblFactoryUnit] as f on cinfo.intFactoryId=f.intFactoryId
	LEFT JOIN [APON].[wms].[tblWarehouse] as o on f.intWarehouseId=o.intWarehouseId
	LEFT JOIN [APON].[pos].[tblPosDeliveryHeader] h on bp.strBusinessPartnerCode = h.strSoldToPartnerCode
	LEFT JOIN [APON].[pos].[tblPosDeliveryRow] r on h.intDeliveryId = r.intDeliveryId

WHERE 
	bp.isActive = 1 AND
	bp.strPartnerSalesType = 'Customer' AND
	cinfo.strFactoryName IS NOT NULL 
	AND cinfo.isActive = 1
GROUP BY
	o.strWarehouseName,
	bp.intBusinessPartnerId,
	bp.strBusinessPartnerCode,
	cinfo.intEmployeeId,
	bp.strBusinessPartnerName,
	bp.strContactNumber,
	cinfo.strDepartment,
	cinfo.strDesignation,
	cinfo.dteJoiningDate,
	cinfo.monGrossSalary
HAVING DATEDIFF(YEAR, cinfo.dteJoiningDate, GETDATE()) >= 5 
AND SUM(r.numItemPrice * r.numQuantity) IS NULL

ORDER BY
	bp.intBusinessPartnerId
