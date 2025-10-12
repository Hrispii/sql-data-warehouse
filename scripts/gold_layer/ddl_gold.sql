------------------------------------------------------------------------------------------
--                                 GOLD LAYER VIEWS                                     --
-- This layer represents the curated, analytics-ready data.                             --
-- Data here is already cleaned, standardized, and enriched from Silver Layer sources.  --
-- It is designed for BI tools, analytics dashboards, and reporting.                    --
------------------------------------------------------------------------------------------
--                                                                                      --
--                                                                                      --
--                                                                                      --
------------------------------------------------------------------------------------------
-- View: goldlayer.dim_customer                                                         --
-- Purpose: Customer dimension table storing demographic and geographic attributes.     --
-- Source Tables: silverlayer.crm_cust_info, silverlayer.erp_cust_az12,                 --
-- silverlayer.erp_loc_a101                                                             --
------------------------------------------------------------------------------------------

CREATE VIEW goldlayer.dim_customer AS
SELECT 
ROW_NUMBER () OVER (ORDER BY cst_id) AS customer_key,
ci.cst_id AS customer_id,
ci.cst_key AS customer_number,
ci.cst_firstname AS first_name,
ci.cst_lastname AS last_name,
CASE 
	WHEN (ci.cst_gndr != 'n/a') THEN ci.cst_gndr -- CRM table is a master
	ELSE coalesce(ca.gen, 'n/a')
END AS gender,
la.cntry AS country,
ci.cst_marital_status AS marital_status,
ca.bdate AS birthday,
ci.cst_create_date AS create_date
FROM silverlayer.crm_cust_info ci
LEFT JOIN silverlayer.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silverlayer.erp_loc_a101 la
ON ci.cst_key = la.cid





CREATE VIEW goldlayer.dim_products AS
SELECT
ROW_NUMBER () OVER (ORDER BY prd_start_dt, dwh_prd_key) AS product_key,
pn.prd_id AS product_id,
pn.dwh_prd_key AS product_number,
pn.prd_nm AS product_name,
pn.dwh_cat_id AS category_id,
pl.cat AS category,
pl.subcat AS subcategory,
pl.maintenance,
pn.prd_cost AS cost,
pn.prd_line AS product_line,
pn.prd_start_dt AS start_date
FROM silverlayer.crm_prd_info pn
LEFT JOIN silverlayer.erp_px_cat_g1v2 pl
ON pn.dwh_cat_id = pl.id
WHERE prd_end_dt IS NULL




CREATE VIEW goldlayer.fact_sales AS
SELECT 
sls_ord_num AS order_number,
pr.product_id,
cs.customer_id,
sls_order_dt AS order_date,
sls_ship_dt AS shipping_date,
sls_due_dt AS due_date,
sls_sales AS sales_amount,
sls_quantity AS quantity,
sls_price AS price
FROM silverlayer.crm_sales_details sd
LEFT JOIN goldlayer.dim_products pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN goldlayer.dim_customer cs
ON sd.sls_cust_id = cs.customer_id
