/*
============================================================================================================
Stored Procedure: Load Bronze Layer (Scource -> Bronze)
============================================================================================================

Script Purpose:
This stored procedure loads into the 'bronze' schema from external CSV files.
it performs the following actions:
- Truncates the bronze before loading data
- uses the 'bulk insert' command to load data from csv files to bronze tables.


parameters:
Non.
This stored procedure does not accept any parameters or return any values.


Usage Example:
Exec bronze.load_bronze;
=============================================================================================================
*/


exec bronze.load_bronze

create or alter procedure bronze.load_bronze as
begin

    declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
    
	    set @batch_start_time = GETDATE();
		print '======================================================================================';
		print 'Loading Bronze Layer';
		print '=======================================================================================';

		print '----------------------------------------------------------------------------------------';
		print 'Loading CRM Tables';
		print '----------------------------------------------------------------------------------------';


		set @start_time = GETDATE();
		print '>> Truncating Table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;

		print '>>Inserting Data Into: bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\Users\Nithin Reddy\Downloads\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		set @end_time = GETDATE();
		print '>>Load Duration:' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print '>>------------';



		select count(*) from bronze.crm_cust_info


		set @start_time = GETDATE();
		print '>> Truncating Table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;


		print '>>Inserting Data Into: bronze.crm_cust_info';
		bulk insert bronze.crm_prd_info
		from 'C:\Users\Nithin Reddy\Downloads\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		set @end_time = GETDATE();
		print '>>Load Duration:' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
		print '>>------------';



		set @start_time = GETDATE();
		print '>> Truncating Table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;

		print '>>Inserting Data Into: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'C:\Users\Nithin Reddy\Downloads\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock 
		);
		set @end_time = GETDATE();
		print '>>Load Duration:' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
        print '>>------------';



		set @start_time = GETDATE();
		print '>> Truncating Table: bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;

		print '>>Inserting Data Into: bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\Nithin Reddy\Downloads\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		set @end_time = GETDATE();
		print '>>Load Duration:' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
        print '>>------------';





		set @start_time = GETDATE();
		print '>> Truncating Table: bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;

		print '>>Inserting Data Into: bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\Nithin Reddy\Downloads\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		set @end_time = GETDATE();
		print '>>Load Duration:' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
        print '>>------------';



		set @start_time = GETDATE();
		print '>> Truncating Table: bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;

		print '>>Inserting Data Into: bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\Nithin Reddy\Downloads\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		set @end_time = GETDATE();
		print '>>Load Duration:' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
        print '>>------------';

		set @batch_end_time = GETDATE();
		print '========================================================================================='
		print 'Loading Bronze layer is completed';
		print ' total load duration: '+ cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + ' seconds';
		end try
		begin catch
		print '========================================================================================================'
		print 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		print 'ERROR Message' + ERROR_MESSAGE();
		print 'Error Message' + cast (ERROR_NUMBER() AS NVARCHAR);
		print 'Error Message' + cast(Error_state() as NVARCHAR);
		PRINT '=========================================================================================================='
		end catch
end






