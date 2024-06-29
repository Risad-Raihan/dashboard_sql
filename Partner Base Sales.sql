SELECT 
  h.strWarehouseName as Outlet,
  --TRIM(REPLACE(SUBSTRING(h.strSoldToPartnerName, 1, CHARINDEX('[', h.strSoldToPartnerName) - 1), '''', '')) as "Customer Name",
  bp.strBusinessPartnerCode as "Customer Code",
  h.strSoldToPartnerName as "Name",
  --LEFT(REPLACE(REPLACE(SUBSTRING(h.strSoldToPartnerName, CHARINDEX('[', h.strSoldToPartnerName), CHARINDEX(']', h.strSoldToPartnerName) - CHARINDEX('[', h.strSoldToPartnerName) + 1), '[', ''), ']', ''), LEN(REPLACE(REPLACE(SUBSTRING(h.strSoldToPartnerName, CHARINDEX('[', h.strSoldToPartnerName), CHARINDEX(']', h.strSoldToPartnerName) - CHARINDEX('[', h.strSoldToPartnerName) + 1), '[', ''), ']', '')) - 1) as "HR Code",
  bp.strBusinessPartnerAddress as "Address",
  bp.strContactNumber as "Contact Number",
  bp.strEmail as "Email",
  bp.strNID as "NID",
  bp.DteDateOfBirth as DOB,
  CASE bp.intGenderId
    WHEN 1 THEN 'Male'
    WHEN 2 THEN 'Female'
  END as Gender,
  cinfo.strDepartment as 'Department',
  cinfo.strDesignation as 'Designation',
  cinfo.dteJoiningDate as 'Joining Date',
  cinfo.monGrossSalary as 'Gross Salary',
  cl.numCreditLimit as "Credit Limit",
  SUM(r.numDeliveryValue) as "Total Sales Amount",
  SUM(r.numTotalDiscountValue) as "Total Discount",
  SUM(h.numCashAmount) as "Cash Amount",
  SUM(h.numCreditAmount) as "Credit Amount",
  SUM(h.numCardAmount) as "Card Amount",
  SUM(h.numMFSAmount) as "MFS Amount",
  bp.isActive as Active
FROM 
  [APON].[pos].[tblPosDeliveryHeader] h
  JOIN [APON].[pos].[tblPosDeliveryRow] r on h.intDeliveryId = r.intDeliveryId
  JOIN [APON].[prt].[tblBusinessPartner] bp on h.strSoldToPartnerCode = bp.strBusinessPartnerCode
  JOIN [APON].[dbo].[CustomerAdditionalInformation] cinfo on bp.intBusinessPartnerId = cinfo.intCustomerId
  JOIN [APON].[prt].[tblBusinessPartnerSalesCreditLimit] cl on bp.intBusinessPartnerId = cl.intBusinessPartnerId
WHERE 
  h.isActive = 1 
  AND r.isActive = 1 
  AND h.dteDeliveryDate BETWEEN '2022-11-01' AND GETDATE()
GROUP BY 
  h.strWarehouseName,
  h.strSoldToPartnerName 
  --TRIM(REPLACE(SUBSTRING(h.strSoldToPartnerName, 1, CHARINDEX('[', h.strSoldToPartnerName) - 1), '''', '')),
  --LEFT(REPLACE(REPLACE(SUBSTRING(h.strSoldToPartnerName, CHARINDEX('[', h.strSoldToPartnerName), CHARINDEX(']', h.strSoldToPartnerName) - CHARINDEX('[', h.strSoldToPartnerName) + 1), '[', ''), ']', ''), LEN(REPLACE(REPLACE(SUBSTRING(h.strSoldToPartnerName, CHARINDEX('[', h.strSoldToPartnerName), CHARINDEX(']', h.strSoldToPartnerName) - CHARINDEX('[', h.strSoldToPartnerName) + 1), '[', ''), ']', '')) - 1),
  bp.strBusinessPartnerName,
  bp.strBusinessPartnerCode,
  bp.strBusinessPartnerAddress,
  bp.strContactNumber,
  bp.strEmail,
  bp.strNID,
  bp.DteDateOfBirth,
  bp.intGenderId,
  bp.isActive,
  cl.numCreditLimit,
  cinfo.strDepartment,
  cinfo.strDesignation,
  cinfo.dteJoiningDate,
  cinfo.monGrossSalary
ORDER BY 
  h.strWarehouseName,
  bp.strBusinessPartnerCode;
