-- TABLE : bronze.crm_cust_info

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT 
	cst_id,
	COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1; 

-- Check for unwanted spaces
-- Expectations: No results

SELECT
	cst_key
FROM bronze.crm_cust_info
WHERE cst_key <> TRIM(cst_key)


-- Data Standardization & Consistency
-- Expectations: No results

SELECT
	DISTINCT(cst_marital_status)
FROM bronze.crm_cust_info

---------------------------------------------------------------------------------

-- TABLE : bronze.crm_prd_info

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT 
	*
FROM bronze.crm_prd_info
WHERE prd_id IS NULL;

SELECT 
	prd_id,
	COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted spaces
-- Expectations: No results

SELECT
	prd_line
FROM bronze.crm_prd_info
WHERE prd_line <> TRIM(prd_line)

SELECT TOP 10
*
FROM bronze.crm_prd_info;

-- Data Standardization & Consistency
-- Expectations: No results

SELECT
	DISTINCT(prd_line)
FROM bronze.crm_prd_info


-- Check for NULLS or negative numbers
-- Expectations: No results

SELECT
	*
FROM bronze.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0;

-- Check for Invalid Date Orders
-- Expectations: No results

SELECT
	*
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt ;


--------------------------------------------------

-- TABLE : bronze.crm_prd_info

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT 
	*
FROM bronze.crm_prd_info
WHERE prd_id IS NULL;

SELECT 
	prd_id,
	COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted spaces
-- Expectations: No results

SELECT
	prd_line
FROM bronze.crm_prd_info
WHERE prd_line <> TRIM(prd_line)

SELECT TOP 10
*
FROM bronze.crm_prd_info;

-- Data Standardization & Consistency
-- Expectations: No results

SELECT
	DISTINCT(prd_line)
FROM bronze.crm_prd_info


-- Check for NULLS or negative numbers
-- Expectations: No results

SELECT
	*
FROM bronze.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0;

-- Check for Invalid Date Orders
-- Expectations: No results

SELECT
	*
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt ;


---------------------------------------------------------------------

-- TABLE : bronze.crm_sales_details

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT TOP 10
*
FROM bronze.crm_sales_details;

SELECT 
	sls_ord_num,
	COUNT(*)
FROM bronze.crm_sales_details
GROUP BY sls_ord_num
HAVING COUNT(*) > 1 OR sls_ord_num IS NULL;

-- Check for unwanted spaces
-- Expectations: No results

SELECT
	sls_ord_num
FROM bronze.crm_sales_details
WHERE sls_ord_num <> TRIM(sls_ord_num)


-- Check for NULLS or negative numbers in sales, quantity and price
-- Check for where sales IS NOT equals price x qunatity
-- Expectations: No results

SELECT 
	sls_sales, 
	sls_quantity,
	sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != (sls_price * sls_quantity)
OR sls_sales IS NULL OR sls_quantity is NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity  <=0 OR sls_price  <=0
ORDER BY sls_sales, sls_quantity, sls_price;




-- Check for NULLS or negative numbers or zeroes for DATE values
-- Expectations: No results

SELECT
	NULLIF(sls_order_dt, 0) AS sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0;

-- Check for DATE values must be in yyymmdd format , length must be EQUALS to 8
-- Expectations: No results

SELECT
	*
FROM bronze.crm_sales_details
WHERE LEN(sls_due_dt) != 8;

-- Check for Invalid order dates
-- Expectations: No results

SELECT
	*
FROM bronze.crm_sales_details
WHERE  sls_ship_dt > sls_due_dt;


---------------------------------------------------------------------

-- TABLE : bronze.erp_cust_az12

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result


USE DataWarehouse
SELECT 
	cid,
	COUNT(*)
FROM bronze.erp_cust_az12
GROUP BY cid
HAVING COUNT(*) > 1 OR cid IS NULL;


-- Check for consitency in gender column , should be only male female or unknown
-- Expectation: No Result

SELECT 
	DISTINCT(gen)
FROM bronze.erp_cust_az12



-- Check for abnormal date values out of range in future and past
-- Expectation: No Result

SELECT 
	bdate
FROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()


---------------------------------------------------------------------

-- TABLE : bronze.erp_loc_a101

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT 
	cid,
	COUNT(*)
FROM bronze.erp_loc_a101
GROUP BY cid
HAVING COUNT(*) > 1 OR cid IS NULL;

-- Check for unexpected characters in cd
-- Expectations: No results

SELECT
	COUNT(*)
FROM bronze.erp_loc_a101
WHERE cid LIKE '__-%';


-- Check for consitency in cntry column , should be only distinct country values with no repeating countries
-- Expectation: distinct country values

SELECT 
	DISTINCT(cntry)
FROM bronze.erp_loc_a101


---------------------------------------------------------------------

-- TABLE : bronze.erp_px_cat_g1v2

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT 
	id,
	COUNT(*)
FROM bronze.erp_px_cat_g1v2
GROUP BY id
HAVING COUNT(*) > 1 OR id IS NULL;


-- Data Standardization & Consistency
-- Expectations: No results

SELECT
	DISTINCT(cat)
FROM bronze.erp_px_cat_g1v2;

SELECT
	DISTINCT(subcat)
FROM bronze.erp_px_cat_g1v2;

SELECT
	DISTINCT(maintenance)
FROM bronze.erp_px_cat_g1v2;
