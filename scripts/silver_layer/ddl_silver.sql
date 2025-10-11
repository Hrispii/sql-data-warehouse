---------------------------------- README -----------------------------------------------
-- Welcome to the Silver Layer Schema!                                                 --
-- This script creates all CRM and ERP tables used in the Silver Layer of              --
-- the Data Warehouse. These tables store cleaned, standardized, and conformed         --
-- data prepared from the Bronze Layer — ensuring it’s ready for analytics, BI, and    --
-- further transformation into the Gold Layer.                                         --
--                                                                                     --
--                              Layer Purpose:                                         --
-- The Silver Layer represents the refined and business-ready stage in the             --
-- Medallion Architecture (Bronze → Silver → Gold). Here, all data from the            --
-- raw Bronze Layer is cleaned, validated, and structured according to business rules. --
-----------------------------------------------------------------------------------------


DROP TABLE IF EXISTS silverlayer.crm_cust_info CASCADE;
CREATE TABLE silverlayer.crm_cust_info(
cst_id int,
cst_key varchar(50),
cst_firstname varchar(50),
cst_lastname varchar(50),
cst_marital_status varchar(50),
cst_gndr varchar(50),
cst_create_date date,
dwh_create_date timestamp DEFAULT clock_timestamp()
);

DROP TABLE IF EXISTS silverlayer.crm_prd_info CASCADE;
CREATE TABLE silverlayer.crm_prd_info(
prd_id int,
dwh_cat_id varchar(50) DEFAULT 0,
dwh_prd_key varchar(50) DEFAULT 0,
prd_nm varchar(50),
prd_cost int,
prd_line varchar(50),
prd_start_dt date,
prd_end_dt date,
dwh_create_date timestamp DEFAULT clock_timestamp()
);

DROP TABLE IF EXISTS silverlayer.crm_sales_details CASCADE;
CREATE TABLE silverlayer.crm_sales_details(
sls_ord_num varchar(50),
sls_prd_key varchar(50),
sls_cust_id int, 
sls_order_dt date,
sls_ship_dt date,
sls_due_dt date,
sls_sales int,
sls_quantity int,
sls_price int,
dwh_create_date timestamp default clock_timestamp()
);

DROP TABLE IF EXISTS silverlayer.erp_cust_az12 CASCADE;
CREATE TABLE silverlayer.erp_cust_az12(
cid varchar(50) DEFAULT NULL,
bdate date,
gen varchar(50),
dwh_create_date timestamp default clock_timestamp()
);

DROP TABLE IF EXISTS silverlayer.erp_loc_a101 CASCADE;
CREATE TABLE silverlayer.erp_loc_a101(
cid varchar(50),
cntry varchar(50),
dwh_create_date timestamp default clock_timestamp()
);

DROP TABLE IF EXISTS silverlayer.erp_px_cat_g1v2 CASCADE;
CREATE TABLE silverlayer.erp_px_cat_g1v2(
id varchar(50),
cat varchar(50),
subcat varchar(50),
maintenance varchar(50),
dwh_create_date timestamp default clock_timestamp()
);
