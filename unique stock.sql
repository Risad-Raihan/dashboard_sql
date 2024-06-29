SELECT
  intItemId AS ID,
  strItemName AS Item_name,
  numCurrentStock AS Stock
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY intItemId ORDER BY strItemName) AS RowNum
  FROM wms.tblItemPlantWarehouse
  WHERE numCurrentStock != '0.000000'
) AS RankedData
WHERE RowNum = 1;
