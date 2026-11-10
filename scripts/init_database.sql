/* 
Script Objective:
    This script creates a new database named 'data_warehouse' after checking if it already exists.
    If the database exists, it is dropped and recreated. Additionally, the script sets up five
    schemas within the database: raw_data_layer, staging_layer, intermediate_layer, core_layer,
    and data_mart_layer.
*/

use master;
go

  --drop and recreate the 'Datawarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'datawarehouse')
  BEGIN
    ALTER DATABASE datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;  
    DROP DATABASE datawarehouse;
  END;
GO

-- create the 'datawarehouse' database
CREATE DATABASE datawarehouse;
GO
  
USE datawarehouse;
GO

--create Schemas
create schema bronze;
go

create schema silver;
go
