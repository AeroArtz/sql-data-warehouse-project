
-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT 
	cst_id,
	COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1; 


-- Check for unwanted spaces
-- Expectations: No results

SELECT
	cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname <> TRIM(cst_lastname)


-- Data Standardization & Consistency
-- Expectations: No results

SELECT
	DISTINCT(cst_gndr)
FROM silver.crm_cust_info



SELECT
	*
FROM silver.crm_cust_info

----------------------------------------------------------------------------


-- TABLE : silver.crm_prd_info

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT 
	*
FROM silver.crm_prd_info
WHERE prd_id IS NULL;

SELECT 
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted spaces
-- Expectations: No results

SELECT
	prd_line
FROM silver.crm_prd_info
WHERE prd_nm <> TRIM(prd_nm)

SELECT TOP 10
*
FROM bronze.crm_prd_info;

-- Data Standardization & Consistency
-- Expectations: No results

SELECT
	DISTINCT(prd_line)
FROM silver.crm_prd_info


-- Check for NULLS or negative numbers
-- Expectations: No results

SELECT
	*
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0;

-- Check for Invalid Date Orders
-- Expectations: No results

SELECT
	*
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt ;


---------------------------------------------------------------------

-- TABLE : bronze.crm_sales_details

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT TOP 10
*
FROM silver.crm_sales_details;

SELECT 
	sls_ord_num
FROM silver.crm_sales_details
WHERE sls_ord_num IS NULL;

-- Check for unwanted spaces
-- Expectations: No results

SELECT
	sls_ord_num
FROM silver.crm_sales_details
WHERE sls_ord_num <> TRIM(sls_ord_num)


-- Check for NULLS or negative numbers in sales, quantity and price
-- Check for where sales IS NOT equals price x qunatity
-- Expectations: No results

SELECT 
	sls_sales, 
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
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
FROM silver.crm_sales_details
WHERE  sls_order_dt > sls_due_dt OR sls_order_dt > sls_due_dt;

---------------------------------------------------------------------

-- TABLE : silver.erp_cust_az12

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result


SELECT 
	cid,
	COUNT(*)
FROM silver.erp_cust_az12
GROUP BY cid
HAVING COUNT(*) > 1 OR cid IS NULL;


-- Check for consitency in gender column , should be only male female or unknown
-- Expectation: No Result

SELECT 
	DISTINCT(gen)
FROM silver.erp_cust_az12



-- Check for abnormal date values out of range in future and past
-- Expectation: No Result

SELECT 
	bdate
FROM silver.erp_cust_az12
WHERE bdate > GETDATE()


SELECT *
FROM silver.erp_cust_az12


---------------------------------------------------------------------

-- TABLE : silver.erp_loc_a101

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT 
	cid,
	COUNT(*)
FROM silver.erp_loc_a101
GROUP BY cid
HAVING COUNT(*) > 1 OR cid IS NULL;

-- Check for unexpected characters in cd
-- Expectations: No results

SELECT
	COUNT(*)
FROM silver.erp_loc_a101
WHERE cid LIKE '__-%';


-- Check for consitency in cntry column , should be only distinct country values with no repeating countries
-- Expectation: distinct country values

SELECT 
	DISTINCT(cntry)
FROM silver.erp_loc_a101

