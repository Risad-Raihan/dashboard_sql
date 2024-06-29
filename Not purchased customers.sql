SELECT
	challan.outlet AS "Outlet",
    bp.strBusinessPartnerCode AS "APON Code",
	challan.c_name AS "Name",
    CASE bp.intGenderId
        WHEN 1 THEN 'Male'
        WHEN 2 THEN 'Female'
    END AS Gender,
	bp.strContactNumber as "Contact Number",
    COALESCE(challan.amount, 0) AS "Total Sales Amount"
FROM
    [APON].[prt].[tblBusinessPartner] bp

LEFT JOIN (
    SELECT
		h.strWarehouseName AS outlet,
        h.strSoldToPartnerCode,
		h.strSoldToPartnerName as c_name,
        SUM(r.numItemPrice * r.numQuantity) AS amount
    FROM
        [APON].[pos].[tblPosDeliveryHeader] h
    JOIN
        [APON].[pos].[tblPosDeliveryRow] r ON h.intDeliveryId = r.intDeliveryId
    WHERE
        h.isActive = 1
        AND r.isActive = 1
        AND h.dteDeliveryDate BETWEEN '2022-09-01' AND '2023-02-28'
    GROUP BY
        h.strWarehouseName, h.strSoldToPartnerCode, h.strSoldToPartnerName
) AS challan ON bp.strBusinessPartnerCode = challan.strSoldToPartnerCode


WHERE
    bp.strBusinessPartnerCode NOT IN (
        SELECT
            h.strSoldToPartnerCode
        FROM
            [APON].[pos].[tblPosDeliveryHeader] h
        JOIN
            [APON].[pos].[tblPosDeliveryRow] r ON h.intDeliveryId = r.intDeliveryId
        WHERE
            h.isActive = 1
            AND r.isActive = 1
            AND h.dteDeliveryDate BETWEEN '2023-03-01' AND '2023-05-31'
    )
AND bp.isActive = 1
AND bp.strPartnerSalesType = 'Customer'
    AND bp.strBusinessPartnerCode IN (
        SELECT
            h.strSoldToPartnerCode
        FROM
            [APON].[pos].[tblPosDeliveryHeader] h
        JOIN
            [APON].[pos].[tblPosDeliveryRow] r ON h.intDeliveryId = r.intDeliveryId
        WHERE
            h.isActive = 1
            AND r.isActive = 1
            AND h.dteDeliveryDate BETWEEN '2022-09-01' AND '2023-02-28'
    );