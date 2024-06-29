-- without Apon Wellbeing Limited Corporate and Demo Outlet do

DECLARE	@BusinessUnitId bigint=0, @WhId bigint=NULL, @PlantId bigint=0, @ItemTypeId int=null,@CategoryId int=null,@SubCategoryId int=null, @FromDate Datetime='2024-01-01',@ToDate DateTime='2024-02-06', @PageNo int, @PageSize int, @Search nvarchar(300)=null 
 
BEGIN
	IF OBJECT_ID('tempdb..#TempALL') IS NOT NULL
    DROP TABLE #TempALL;

	IF OBJECT_ID('tempdb..#TempOpening') IS NOT NULL
		DROP TABLE #TempOpening;

	IF OBJECT_ID('tempdb..#TempClossing') IS NOT NULL
		DROP TABLE #TempClossing;

	SET @WhId=CASE WHEN @WhId=0 THEN NULL ELSE @WhId END

    DECLARE @damageId bigint, @dteOpenToDate DATE,@TotalRows bigint
    SELECT @damageId=intInventoryLocationId FROM wms.tblInventoryLocation WHERE isActive=1 AND strInventoryLocationName='Damaged Goods Stock'
	SET @dteOpenToDate=DATEADD(dd, 1, @ToDate)



	 SELECT *
	 	
		INTO #TempALL
	 FROM(
		SELECT    t.strWhName,t.intWhId, t.ItemId, t.strItemName, t.strCode as strItemCode, pw.strBaseUOM AS strUomName, 
 
		SUM(CASE WHEN t.intType=8 THEN t.numQty ELSE 0 END) AS numProductionQty,
		SUM(CASE WHEN t.intType=8 THEN t.numQty  ELSE 0 END)* SUM(CASE WHEN t.intType=8 THEN  t.numRate ELSE 0 END) AS numProductionValue,
		SUM(CASE WHEN t.intType in (1,6) THEN t.numQty ELSE 0 END) AS numReceiveQty,
		--SUM(CASE WHEN t.intType in (1,6) THEN t.numQty  ELSE 0 END) * SUM(CASE WHEN t.intType in (1,6) THEN t.numRate ELSE 0 END) AS numReceiveValue,
		SUM(CASE WHEN t.intType in (9,10,11,12,13,14) THEN t.numQty ELSE 0 END) AS numIssueQty,
		--SUM(CASE WHEN t.intType in (9,10,11,12,13,14) THEN t.numQty  ELSE 0 END) *SUM(CASE WHEN t.intType in (9,10,11,12,13,14) THEN  t.numRate ELSE 0 END)AS numIssueValue,
		SUM(CASE WHEN t.intType in (22,25) THEN t.numQty ELSE 0 END) AS numAdjustQty,
		--SUM(CASE WHEN t.intType in (22,25) THEN t.numQty  ELSE 0 END)*SUM(CASE WHEN t.intType in (22,25) THEN  t.numRate ELSE 0 END) AS numAdjustValue,
		SUM(CASE WHEN t.intType in (15,35) THEN t.numQty ELSE 0 END) AS numPurReturnQty,
		--SUM(CASE WHEN t.intType in (15,35) THEN t.numQty  ELSE 0 END)*SUM(CASE WHEN t.intType in (15,35) THEN t.numRate ELSE 0 END) AS numPurReturnValue,
		SUM(CASE WHEN t.intType in (19) THEN t.numQty ELSE 0 END) AS numTransOutQty,
		--SUM(CASE WHEN t.intType in (19) THEN t.numQty  ELSE 0 END)*SUM(CASE WHEN t.intType in (19) THEN  t.numRate ELSE 0 END) AS numTransOutValue,
		SUM(CASE WHEN t.intType in (5) THEN t.numQty ELSE 0 END) AS numTransInQty,
		--SUM(CASE WHEN t.intType in (5) THEN t.numQty  ELSE 0 END)*SUM(CASE WHEN t.intType in (5) THEN  t.numRate ELSE 0 END) AS numTransInValue,
		SUM(CASE WHEN t.intType in (12,61) THEN t.numQty ELSE 0 END) AS numSalesQty,
		--SUM(CASE WHEN t.intType in (12,61) THEN t.numQty  ELSE 0 END) *SUM(CASE WHEN t.intType in (12,61) THEN t.numRate ELSE 0 END) AS numSalesValue,
		SUM(CASE WHEN t.intType in (15,57,60) THEN t.numQty ELSE 0 END) AS numOtherQty,
		SUM(CASE WHEN t.intType in (15,57,60) THEN t.numQty  ELSE 0 END)*
		SUM(CASE WHEN t.intType in (15,57,60) THEN t.numRate ELSE 0 END)AS numOtherValue
 
		
	
		
		FROM(
		SELECT h.intWarehouseId intWhId,w.strWarehouseName strWhName, r.intItemId ItemId, i.strItemName strItemName, ISNULL(i.strItemCode,'NA') strCode, SUM(r.numTransactionQuantity) AS numQty,
		isnull(SUM(CASE WHEN tt.isValuation=1 THEN r.monTransactionValue ELSE 0 END)
		/CASE WHEN SUM(CASE WHEN tt.isValuation=1 THEN r.numTransactionQuantity ELSE 0 END)=0 THEN 1 
		ELSE SUM(CASE WHEN tt.isValuation=1 THEN r.numTransactionQuantity ELSE 0 END) END ,0)AS numRate, 
		tt.intInventoryTransactionTypeId intType, ISNULL(tt.isValuation,0) isValuation, 0 intFromWHId
		FROM wms.tblInventoryTransactionHeader h 
		JOIN wms.tblWarehouse w ON h.intWarehouseId=w.intWarehouseId
		JOIN wms.tblInventoryTransactionRow r ON h.intInventoryTransactionId=r.intInventoryTransactionId
		JOIN wms.tblInventoryTransactionType tt ON h.intTransactionTypeId=tt.intInventoryTransactionTypeId
		JOIN itm.tblItem i ON r.intItemId=i.intItemId
	
		WHERE (cast(h.dteTransactionDate as date) BETWEEN @FromDate AND @ToDate)  
	    AND h.isActive=1 and h.isApproved=1 AND r.isActive=1 AND  
	 
	    
		CASE WHEN isnull(@WhId,0)=0 then 1 WHEN @WhId=0 THEN 1 WHEN @WhId=h.intWarehouseId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@ItemTypeId,0)=0 then 1 WHEN @ItemTypeId=0 THEN 1 WHEN @ItemTypeId=i.intItemTypeId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@CategoryId,0)=0 then 1 WHEN @CategoryId=0 THEN 1 WHEN @CategoryId=i.intItemCategoryId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@SubCategoryId,0)=0 then 1 WHEN @SubCategoryId=0 THEN 1 WHEN @SubCategoryId=i.intItemSubCategoryId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@Search,'')='' then 1  WHEN  (i.strItemName like '%'+@Search+'%' OR i.strItemCode like '%'+@Search+'%') THEN 1 ELSE 0 END=1
 
		GROUP BY h.intWarehouseId, r.intItemId, i.strItemName, i.strItemCode, h.intTransactionTypeId, tt.intInventoryTransactionTypeId, tt.isValuation,
		w.strWarehouseName
		)t
		 JOIN wms.tblItemPlantWarehouse pw ON t.ItemId=pw.intItemId AND t.intWhId=pw.intWarehouseId
		 WHERE pw.IntInventoryLocationId!=@damageId  
	    GROUP BY t.strWhName,t.intWhId, t.ItemId, t.strItemName, t.strCode , pw.strBaseUOM  
		)T
 



		SELECT  t.intWhId, t.ItemId,
	
		SUM(t.numQty) AS numOpenQty, 
		SUM(t.numQty)*SUM(t.numRate) AS numOpenValue

		INTO #TempOpening
		
		FROM(
		SELECT h.intWarehouseId intWhId,w.strWarehouseName strWhName, r.intItemId ItemId, i.strItemName strItemName, ISNULL(i.strItemCode,'NA') strCode, SUM(r.numTransactionQuantity) AS numQty,
		isnull(SUM(CASE WHEN tt.isValuation=1 THEN r.monTransactionValue ELSE 0 END)
		/CASE WHEN SUM(CASE WHEN tt.isValuation=1 THEN r.numTransactionQuantity ELSE 0 END)=0 THEN 1 
		ELSE SUM(CASE WHEN tt.isValuation=1 THEN r.numTransactionQuantity ELSE 0 END) END ,0)AS numRate, 
		tt.intInventoryTransactionTypeId intType, ISNULL(tt.isValuation,0) isValuation, 0 intFromWHId
		FROM wms.tblInventoryTransactionHeader h 
		JOIN wms.tblWarehouse w ON h.intWarehouseId=w.intWarehouseId
		JOIN wms.tblInventoryTransactionRow r ON h.intInventoryTransactionId=r.intInventoryTransactionId
		JOIN wms.tblInventoryTransactionType tt ON h.intTransactionTypeId=tt.intInventoryTransactionTypeId
		JOIN itm.tblItem i ON r.intItemId=i.intItemId
	
		WHERE (cast(h.dteTransactionDate as date) < @FromDate )  
	    AND h.isActive=1 and h.isApproved=1 AND r.isActive=1 AND  
	 
	    
		CASE WHEN isnull(@WhId,0)=0 then 1 WHEN @WhId=0 THEN 1 WHEN @WhId=h.intWarehouseId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@ItemTypeId,0)=0 then 1 WHEN @ItemTypeId=0 THEN 1 WHEN @ItemTypeId=i.intItemTypeId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@CategoryId,0)=0 then 1 WHEN @CategoryId=0 THEN 1 WHEN @CategoryId=i.intItemCategoryId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@SubCategoryId,0)=0 then 1 WHEN @SubCategoryId=0 THEN 1 WHEN @SubCategoryId=i.intItemSubCategoryId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@Search,'')='' then 1  WHEN  (i.strItemName like '%'+@Search+'%' OR i.strItemCode like '%'+@Search+'%') THEN 1 ELSE 0 END=1
 
		GROUP BY h.intWarehouseId, r.intItemId, i.strItemName, i.strItemCode, h.intTransactionTypeId, tt.intInventoryTransactionTypeId, tt.isValuation,
		w.strWarehouseName
		)t
		 JOIN wms.tblItemPlantWarehouse pw ON t.ItemId=pw.intItemId AND t.intWhId=pw.intWarehouseId
		 WHERE pw.IntInventoryLocationId!=@damageId 
		 GROUP BY t.intWhId, t.ItemId
		  order by t.ItemId
		    
	 



		
	    SELECT  t.intWhId, t.ItemId, 
		SUM( t.numQty ) AS numClossingQty,
		SUM(  t.numQty)*SUM(t.numRate ) AS numClossingValue
 
		INTO #TempClossing
		
		FROM(
		SELECT h.intWarehouseId intWhId,w.strWarehouseName strWhName, r.intItemId ItemId, i.strItemName strItemName, ISNULL(i.strItemCode,'NA') strCode, SUM(r.numTransactionQuantity) AS numQty,
		isnull(SUM(CASE WHEN tt.isValuation=1 THEN r.monTransactionValue ELSE 0 END)
		/CASE WHEN SUM(CASE WHEN tt.isValuation=1 THEN r.numTransactionQuantity ELSE 0 END)=0 THEN 1 
		ELSE SUM(CASE WHEN tt.isValuation=1 THEN r.numTransactionQuantity ELSE 0 END) END ,0)AS numRate, 
		tt.intInventoryTransactionTypeId intType, ISNULL(tt.isValuation,0) isValuation, 0 intFromWHId
		FROM wms.tblInventoryTransactionHeader h 
		JOIN wms.tblWarehouse w ON h.intWarehouseId=w.intWarehouseId
		JOIN wms.tblInventoryTransactionRow r ON h.intInventoryTransactionId=r.intInventoryTransactionId
		JOIN wms.tblInventoryTransactionType tt ON h.intTransactionTypeId=tt.intInventoryTransactionTypeId
		JOIN itm.tblItem i ON r.intItemId=i.intItemId
	
		WHERE (cast(h.dteTransactionDate as date) <= @ToDate)  
	    AND h.isActive=1 and h.isApproved=1 AND r.isActive=1 AND  
	 
	    
		CASE WHEN isnull(@WhId,0)=0 then 1 WHEN @WhId=0 THEN 1 WHEN @WhId=h.intWarehouseId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@ItemTypeId,0)=0 then 1 WHEN @ItemTypeId=0 THEN 1 WHEN @ItemTypeId=i.intItemTypeId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@CategoryId,0)=0 then 1 WHEN @CategoryId=0 THEN 1 WHEN @CategoryId=i.intItemCategoryId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@SubCategoryId,0)=0 then 1 WHEN @SubCategoryId=0 THEN 1 WHEN @SubCategoryId=i.intItemSubCategoryId THEN 1 ELSE 0 END=1
		AND CASE WHEN isnull(@Search,'')='' then 1  WHEN  (i.strItemName like '%'+@Search+'%' OR i.strItemCode like '%'+@Search+'%') THEN 1 ELSE 0 END=1
 
		GROUP BY h.intWarehouseId, r.intItemId, i.strItemName, i.strItemCode, h.intTransactionTypeId, tt.intInventoryTransactionTypeId, tt.isValuation,
		w.strWarehouseName
		)t
		 JOIN wms.tblItemPlantWarehouse pw ON t.ItemId=pw.intItemId AND t.intWhId=pw.intWarehouseId
		 WHERE pw.IntInventoryLocationId!=@damageId  
		 GROUP BY t.intWhId, t.ItemId
		order by t.ItemId
		 

		
		 
		SELECT t.strWhName as "Outlet",strItemCode as "Item Code", t.strItemName as "Item Name", strUomName,
		isnull(numOpenQty,0) numOpenQty,isnull(numOpenValue,0) numOpenValue,numAdjustQty,numReceiveQty,
		numIssueQty,numPurReturnQty,
		numTransInQty, numTransOutQty,
		isnull(numClossingQty,0) numClossingQty, isnull(numClossingValue,0) numClossingValue from #TempALL T
		left Join #TempOpening o on T.ItemId=o.ItemId AND T.intWhId=o.intWhId
		left Join #TempClossing c on T.ItemId=c.ItemId AND T.intWhId=c.intWhId
 
 
 

	DROP TABLE #TempALL,#TempOpening,#TempClossing
 
 END