/*
====================================================================================================
Quality Checks
====================================================================================================
Script Purpose:
              This script performs various quality checks for data consistency, accuracy,
              and standardization across the 'silver' schemas. it includes checks for:
              - Null or duplicates primary keys.
              - Unwanted spaces in string fields.
              - Data Standardization and consistency.
              - Invalid date ranges and orders
              - Data Consistecy between related fields.
Usage Notes: 
            - Run these checks after data loading silver layer.
            - Investigate and resolve any discrepancies found during the checks 
======================================================================================================
Definitions: 

Remove Unwanted Spaces

Removes unnecessary spaces to ensure data consistency, and uniformity across all records.



Data Normalization and standardization (case when statements)
Maps coded values to meaningful, user-friendly descriptions.


Handling Missing Data
Fills in the blanks by adding a default value



Remove Duplicates
Ensure only one record per entity by identifying and retaining the most relevant row.


Data Enrichment: Add new, relevant data to enhance the dataset for analysis.



*/





--Quality checks
--Check for nulls or duplicates in primary key
-- expectations: No result
select
prd_id,
count(*)
from silver.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id is null





--check unwanted spaces
--expectation : no results

select 
prd_nm

from silver.crm_prd_info
where prd_nm != trim(prd_nm)



--check for nulls or negative numbers
--expectation: No results

select prd_cost
from silver.crm_prd_info
where prd_cost < 0 or prd_cost is  null


--check Data Standardization & consistency
select distinct prd_line
from silver.crm_prd_info



--check for invaid date orders
select * from
silver.crm_prd_info
where prd_end_dt < prd_start_dt


select * from silver.crm_prd_info
=================================================
  select
cst_key
from bronze.crm_cust_info
where cst_key != trim(cst_key)


--data standadization & consistency

select
distinct cst_gndr
from silver.crm_cust_info


select
distinct cst_martial_status
from silver.crm_cust_info



select * from silver.crm_cust_info;


--===================================================
--check for nulls or duplicates in primary key
-- expectation: no result

select 
prd_id,
count(*)
from bronze.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id is null



==================================================
  --check for unwanted spcaes

select * from bronze.erp_px_cat_g1v2
where cat != trim(cat) or subcat != trim(subcat) or maintenance != trim(maintenance)


--Data Standardization And Consistency

select distinct
maintenance
from bronze.erp_px_cat_g1v2




select * from silver.erp_px_cat_g1v2
=============================================================
  --identify out of range dates

select distinct
bdate
from silver.erp_cust_az12
where bdate < '1924-01-01' or bdate > getdate()



--check standardization and consistency

select  distinct
gen
from silver.erp_cust_az12


select * from silver.erp_cust_az12
============================================================================================
  select 
replace(cid, '-','') cid,
case when trim(cntry) = 'DE' then 'Germany'
     when trim(cntry) in ('US','USA') then 'United States'
     when trim(cntry) = '' OR cntry is null then 'N/A'
     else cntry
end as cntry
from silver.erp_loc_a101


--data standardization and consistecy

select distinct
cntry
from silver.erp_loc_a101
order by cntry

select * from silver.erp_loc_a101
=========================================================================================================

  



================
