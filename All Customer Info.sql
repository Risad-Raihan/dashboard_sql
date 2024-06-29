SELECT
	o.strWarehouseName as "Outlet",
	bp.strBusinessPartnerCode as "APON Code",
	bp.strBusinessPartnerName as "Name",
	cinfo.intEmployeeId as "HR Code",
	cinfo.intMaritalStatus as "Marital Status",
	cinfo.intNumberOfFamilyMember as "Number of Family Member",
	bp.strBusinessPartnerAddress as "Address",
	bp.strContactNumber as "Contact Number",
	bp.strEmail as "Email",
	CASE bp.intGenderId
	WHEN 1 THEN 'Male'
	WHEN 2 THEN 'Female'
	END as Gender,
	bp.strNID as "NID",
	bp.DteDateOfBirth as DOB,
	cinfo.strDepartment as 'Department',
	cinfo.strDesignation as 'Designation',
	cinfo.dteJoiningDate as 'Joining Date',
	cinfo.monGrossSalary as 'Gross Salary',
	bp.numDistributorCreditLimit as "Credit Limit",
	bp.isActive,
	bp.dteLastActionDateTime
  FROM [APON].[prt].[tblBusinessPartner] bp
	LEFT JOIN [APON].[dbo].[CustomerAdditionalInformation] cinfo on bp.intBusinessPartnerId = cinfo.intCustomerId
	LEFT JOIN [APON].[prt].[tblFactoryUnit] as f on cinfo.intFactoryId=f.intFactoryId
	LEFT JOIN [APON].[wms].[tblWarehouse] as o on f.intWarehouseId=o.intWarehouseId

WHERE 
	--bp.isActive = 1 AND
	bp.strPartnerSalesType = 'Customer' AND
	cinfo.strFactoryName IS NOT NULL AND
	o.strWarehouseName IS NOT NULL

ORDER BY
	bp.intBusinessPartnerId
