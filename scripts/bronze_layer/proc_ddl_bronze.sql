CREATE OR REPLACE PROCEDURE bronzelayer.load_bronze()
LANGUAGE plpgsql
AS $procedure$
DECLARE
    start_time timestamp;
    end_time timestamp;
	erp_time numeric := 0;
	full_time numeric := 0;
BEGIN
    RAISE NOTICE '%', repeat('=', 30);
    RAISE NOTICE '     Loading Bronze Layer ';
    RAISE NOTICE '%', repeat('=', 30);

    RAISE NOTICE '%', repeat('-', 30);
    RAISE NOTICE '      Loading CRM Tables ';
    RAISE NOTICE '%', repeat('-', 30);

	--                                          CRM
    -- CRM_CUST_INFO
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.crm_cust_info;
    COPY bronzelayer.crm_cust_info
    FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
    DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Load duration of crm_cust_info: %', extract(epoch from (end_time - start_time));
	full_time := full_time + extract(epoch from (end_time - start_time));

    -- CRM_PRD_INFO
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.crm_prd_info;
    COPY bronzelayer.crm_prd_info
    FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
    DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Load duration of crm_prd_info: %', extract(epoch from (end_time - start_time));
	full_time := full_time + extract(epoch from (end_time - start_time));

    -- CRM_SALES_DETAILS
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.crm_sales_details;
    COPY bronzelayer.crm_sales_details
    FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
    DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Load duration of crm_sales_details: %', extract(epoch from (end_time - start_time));
	full_time := full_time + extract(epoch from (end_time - start_time));

	--Allert crm duration
	RAISE NOTICE '%', repeat('-', 30);
	RAISE NOTICE 'CRM Loading Time: %', full_time;
	RAISE NOTICE '%', repeat('-', 30);

	--Allert load ERP tables
    RAISE NOTICE '%', repeat('-', 30);
    RAISE NOTICE '      Loading ERP Tables ';
    RAISE NOTICE '%', repeat('-', 30);

	--                                          ERP
    -- ERP_CUST_AZ12
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.erp_cust_az12;
    COPY bronzelayer.erp_cust_az12
    FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
    DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Load duration of erp_cust_az12: %', extract(epoch from (end_time - start_time));
	erp_time := full_time + extract(epoch from (end_time - start_time));
	full_time := full_time + extract(epoch from (end_time - start_time));

    -- ERP_LOC_A101
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.erp_loc_a101;
    COPY bronzelayer.erp_loc_a101
    FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
    DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Load duration of erp_loc_a101: %', extract(epoch from (end_time - start_time));
	erp_time := full_time + extract(epoch from (end_time - start_time));
	full_time := full_time + extract(epoch from (end_time - start_time));

    -- ERP_PX_CAT_G1V2
    start_time := clock_timestamp();
    TRUNCATE bronzelayer.erp_px_cat_g1v2;
    COPY bronzelayer.erp_px_cat_g1v2
    FROM 'C:\mylogovo\Courses\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
    DELIMITER ',' CSV HEADER;
    end_time := clock_timestamp();
    RAISE NOTICE 'Load duration of erp_px_cat_g1v2: %', extract(epoch from (end_time - start_time));
	erp_time := full_time + extract(epoch from (end_time - start_time));
	full_time := full_time + extract(epoch from (end_time - start_time));

	--Allert crm duration
	RAISE NOTICE '%', repeat('-', 30);
	RAISE NOTICE 'ERP Loading Time: %', erp_time;
	RAISE NOTICE '%', repeat('-', 30);

	--Allert Successful
    RAISE NOTICE '%', repeat('=', 30);
    RAISE NOTICE '          Successful! ';
	RAISE NOTICE '      Duration: %', full_time;
    RAISE NOTICE '%', repeat('=', 30);

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error Message: %', SQLERRM;
END;
$procedure$;
