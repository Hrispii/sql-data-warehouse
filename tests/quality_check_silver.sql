-- ============================================================
-- 🔍 DATA QUALITY TESTS FOR SILVER LAYER
-- ============================================================


-- ============================================================
-- EXPECTATION: Each SELECT should return either 0 rows
-- or clearly explain which data needs correction.
-- ============================================================
-- ==========================
-- Checking 'silver.crm_cust_info'
-- ==========================

-- Check for NULL or Empty Values
SELECT *
FROM silverlayer.crm_cust_info
WHERE cst_id IS NULL
   OR TRIM(cst_firstname) = ''
   OR TRIM(cst_lastname) = '';

-- Check for Unwanted Spaces
SELECT *
FROM silverlayer.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
   OR cst_lastname != TRIM(cst_lastname)
   OR cst_marital_status != TRIM(cst_marital_status)
   OR cst_gndr != TRIM(cst_gndr);

-- Data Standardization & Consistency
SELECT DISTINCT cst_marital_status FROM silverlayer.crm_cust_info;
SELECT DISTINCT cst_gndr FROM silverlayer.crm_cust_info;

-- Duplicate Check
SELECT cst_id, COUNT(*) 
FROM silverlayer.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;

-- ==========================
-- Checking 'silver.crm_prd_info'
-- ==========================

-- Check for Invalid or Missing Data
SELECT *
FROM silverlayer.crm_prd_info
WHERE prd_id IS NULL
   OR prd_cost < 0
   OR prd_nm IS NULL;

-- Check for Unwanted Spaces
SELECT *
FROM silverlayer.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)
   OR prd_line != TRIM(prd_line);

-- Data Standardization & Consistency
SELECT DISTINCT prd_line FROM silverlayer.crm_prd_info ORDER BY prd_line;

-- Check for Date Consistency
SELECT *
FROM silverlayer.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ==========================
-- Checking 'silver.crm_sales_details'
-- ==========================

-- Check for Invalid Dates
SELECT *
FROM silverlayer.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_sales < 0
   OR sls_quantity < 0;

-- Check for Unwanted Spaces
SELECT *
FROM silverlayer.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num)
   OR sls_prd_key != TRIM(sls_prd_key);

-- Data Standardization & Consistency
SELECT DISTINCT sls_price FROM silverlayer.crm_sales_details WHERE sls_price IS NULL;

-- ==========================
-- Checking 'silver.erp_cust_az12'
-- ==========================

-- Check for Future Birth Dates
SELECT *
FROM silverlayer.erp_cust_az12
WHERE bdate > clock_timestamp(); 

-- Check Gender Standardization
SELECT DISTINCT gen FROM silverlayer.erp_cust_az12;

-- ==========================
-- Checking 'silver.erp_loc_a101'
-- ==========================

-- Check for NULL or Empty Values
SELECT *
FROM silverlayer.erp_loc_a101
WHERE cid IS NULL OR cntry IS NULL OR TRIM(cntry) = '';

-- Check for Unwanted Spaces
SELECT *
FROM silverlayer.erp_loc_a101
WHERE cntry != TRIM(cntry);

-- Data Standardization & Consistency
SELECT DISTINCT cntry FROM silverlayer.erp_loc_a101 ORDER BY cntry;

-- ==========================
-- Checking 'silver.erp_px_cat_g1v2'
-- ==========================

-- Check for Unwanted Spaces
SELECT *
FROM silverlayer.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
   OR subcat != TRIM(subcat)
   OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency
SELECT DISTINCT maintenance FROM silverlayer.erp_px_cat_g1v2;

-- Duplicate Check
SELECT id, COUNT(*)
FROM silverlayer.erp_px_cat_g1v2
GROUP BY id
HAVING COUNT(*) > 1;
