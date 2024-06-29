SELECT
-- SL#	Factory	Customer Code	Customer Name	Address	Contact Number	Email Address	Gender	NID Number	Date of Birth	Department	Credit
	ROW_NUMBER() over (ORDER BY bp.intBusinessPartnerId) as "SL#",
	h.strWarehouseName as Factory,
	h.strSoldToPartnerCode as "Customer Code",
	TRIM(REPLACE(SUBSTRING(h.strSoldToPartnerName, 1, CHARINDEX('[', h.strSoldToPartnerName) - 1), '''', '')) as "Customer Name",
	bp.strBusinessPartnerAddress as "Address",
	bp.strContactNumber as "Contact Number",
	bp.strEmail as "Email Address",
	CASE bp.intGenderId
	WHEN 1 THEN 'Male'
	WHEN 2 THEN 'Female'
	END as Gender,
	bp.strNID as "NID Number",
	bp.DteDateOfBirth as "Date of Birth",
	cinfo.strDepartment as "Department",
	SUM(h.numCreditAmount) as Credit,
	LEFT(REPLACE(REPLACE(SUBSTRING(h.strSoldToPartnerName, CHARINDEX('[', h.strSoldToPartnerName), CHARINDEX(']', h.strSoldToPartnerName) - CHARINDEX('[', h.strSoldToPartnerName) + 1), '[', ''), ']', ''), LEN(REPLACE(REPLACE(SUBSTRING(h.strSoldToPartnerName, CHARINDEX('[', h.strSoldToPartnerName), CHARINDEX(']', h.strSoldToPartnerName) - CHARINDEX('[', h.strSoldToPartnerName) + 1), '[', ''), ']', '')) - 1) as "HR Code"
 
FROM [APON].[pos].[tblPosDeliveryHeader] h
	JOIN [APON].[pos].[tblPosDeliveryRow] r on h.intDeliveryId = r.intDeliveryId
	JOIN [APON].[prt].[tblBusinessPartner] bp on  h.strSoldToPartnerCode = bp.strBusinessPartnerCode
	JOIN [APON].[dbo].[CustomerAdditionalInformation] cinfo on bp.intBusinessPartnerId = cinfo.intCustomerId

WHERE 
	h.isActive = 1 AND
	bp.strPartnerSalesType = 'Customer' AND
	--LEN(bp.strContactNumber) = 11 AND
	--(LEN(bp.strNID) = 17 OR LEN(bp.strNID) = 13 OR LEN(bp.strNID) = 10) AND
	h.dteDeliveryDate between '2023-03-01' 
	and '2023-03-31' 

GROUP BY
	h.strWarehouseName,
	bp.intBusinessPartnerId,
	h.strSoldToPartnerCode,
	h.strSoldToPartnerName,
	bp.strBusinessPartnerAddress,
	bp.strContactNumber,
	bp.strEmail,
	bp.strNID,
	bp.DteDateOfBirth,
	bp.intGenderId,
	cinfo.strDepartment
ORDER BY
	bp.intBusinessPartnerId
