---------------------------------- README -----------------------------------------------
-- Welcome to the Bronze Layer Loader!                                                 --
-- This procedure ingests raw CRM and ERP datasets from external CSV sources           --
-- into the Bronze Layer of the Data Warehouse. It performs a full refresh by          --
-- truncating existing tables, reloading new data, and logging execution metrics.      --
--                                                                                     --
--                                Features:                                            --
-- Loads raw source files (CSV) into the DWH staging zone                              --
-- Measures and reports load time per table and total duration                         --
-- Prints clear progress logs for monitoring and debugging                             --
--                                                                                     --
--                               Layer Purpose:                                        --
-- The Bronze Layer acts as the raw data landing zone within the Medallion             --
-- architecture. It holds unmodified, source-level data — the foundation for further   --
-- transformation in the Silver Layer.                                                 --
--                                                                                     --
--                             Execution Command:                                      --
-- To run the full ingestion pipeline:                                                 --
-- CALL bronzelayer.load_bronze();                                                     --
--                                                                                     --
--                             Technical Overview:                                     --
--  Language: PL/pgSQL (PostgreSQL Stored Procedure)                                   --
--  Handles both CRM and ERP data imports                                              --
--  Uses PostgreSQL’s COPY command for efficient bulk loading                          --
--  Tracks execution time and prints detailed logs per dataset                         --
-----------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE bronzelayer.load_bronze()
LANGUAGE plpgsql
AS $procedure$
DECLARE
    start_time   timestamp;
    end_time     timestamp;
    crm_time     numeric := 0;
    erp_time     numeric := 0;
    full_time    numeric := 0;
BEGIN
    RAISE NOTICE '%', repeat('=', 40);
    RAISE NOTICE '         LOADING BRONZE LAYER';
    RAISE NOTICE '%', repeat('=', 40);

    -- ===============================================
    --                 CRM TABLES
    -- ===============================================
    RAISE NOTICE '%', repeat('-', 40);
    RAISE NOTICE '           Loading CRM Tables';
    RAISE NOTICE '%', repeat('-', 40);

    --------------------------------------------------
    --               CRM_CUST_INFO                  --
    
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.crm_cust_info;
    COPY bronzelayer.crm_cust_info
        FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
        DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Loaded crm_cust_info in % seconds', extract(epoch FROM (end_time - start_time));
    crm_time  := crm_time + extract(epoch FROM (end_time - start_time));
    full_time := full_time + extract(epoch FROM (end_time - start_time));

    -------------------------------------------------
    --               CRM_PRD_INFO                  --
    
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.crm_prd_info;
    COPY bronzelayer.crm_prd_info
        FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
        DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Loaded crm_prd_info in % seconds', extract(epoch FROM (end_time - start_time));
    crm_time  := crm_time + extract(epoch FROM (end_time - start_time));
    full_time := full_time + extract(epoch FROM (end_time - start_time));

    ------------------------------------------------------
    --               CRM_SALES_DETAILS                  --
    
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.crm_sales_details;
    COPY bronzelayer.crm_sales_details
        FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
        DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Loaded crm_sales_details in % seconds', extract(epoch FROM (end_time - start_time));
    crm_time  := crm_time + extract(epoch FROM (end_time - start_time));
    full_time := full_time + extract(epoch FROM (end_time - start_time));

    RAISE NOTICE '%', repeat('-', 40);
    RAISE NOTICE 'CRM Loading Time: % seconds', crm_time;
    RAISE NOTICE '%', repeat('-', 40);

    -- ===============================================
    --                 ERP TABLES
    -- ===============================================
    RAISE NOTICE '%', repeat('-', 40);
    RAISE NOTICE '           Loading ERP Tables';
    RAISE NOTICE '%', repeat('-', 40);

    --------------------------------------------------
    --               ERP_CUST_AZ12                  --
    
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.erp_cust_az12;
    COPY bronzelayer.erp_cust_az12
        FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
        DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Loaded erp_cust_az12 in % seconds', extract(epoch FROM (end_time - start_time));
    erp_time  := erp_time + extract(epoch FROM (end_time - start_time));
    full_time := full_time + extract(epoch FROM (end_time - start_time));

    -------------------------------------------------
    --               ERP_LOC_A101                  --
    
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.erp_loc_a101;
    COPY bronzelayer.erp_loc_a101
        FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
        DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Loaded erp_loc_a101 in % seconds', extract(epoch FROM (end_time - start_time));
    erp_time  := erp_time + extract(epoch FROM (end_time - start_time));
    full_time := full_time + extract(epoch FROM (end_time - start_time));

    ----------------------------------------------------
    --               ERP_PX_CAT_G1V2                  --
    
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.erp_px_cat_g1v2;
    COPY bronzelayer.erp_px_cat_g1v2
        FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
        DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Loaded erp_px_cat_g1v2 in % seconds', extract(epoch FROM (end_time - start_time));
    erp_time  := erp_time + extract(epoch FROM (end_time - start_time));
    full_time := full_time + extract(epoch FROM (end_time - start_time));

    RAISE NOTICE '%', repeat('-', 40);
    RAISE NOTICE 'ERP Loading Time: % seconds', erp_time;
    RAISE NOTICE '%', repeat('-', 40);

    -- ===============================================
    --             FINAL SUCCESS MESSAGE
    -- ===============================================
    RAISE NOTICE '%', repeat('=', 40);
    RAISE NOTICE '          Successful!          ';
    RAISE NOTICE 'Duration: % seconds', full_time;
    RAISE NOTICE '%', repeat('=', 40);

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error while loading Br
