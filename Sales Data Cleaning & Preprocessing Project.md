# Sales Data Cleaning & Preprocessing Project

##  Project Overview
This project demonstrates a comprehensive data cleaning and preprocessing workflow using a sample sales dataset. The dataset contains order, customer, product, and geographical information. The goal is to clean, standardize, and validate the data to prepare it for data analysis, visualization, and reporting.

### Key objectives:
 - Identify and handle missing, blank, and malformed data.

 - Standardize categorical and date fields.

 - Create derived columns for better usability.

 - Detect and report duplicate records.


## 📂 Dataset
This project demonstrates SQL-based data cleaning and preprocessing using a real-world dataset.This datateset is gotten from kaggle.com
The dataset used in this project is:  
[sales_data_sample.csv](https://www.kaggle.com/kyanyoga/sample-sales-data)


| Column Name               | Description                           |
| ------------------------- | ------------------------------------- |
| ORDERNUMBER               | Unique order identifier               |
| QUANTITYORDERED           | Quantity of products in the order     |
| PRICEEACH                 | Unit price of the product             |
| ORDERLINENUMBER           | Line number in the order              |
| SALES                     | Total sales amount                    |
| ORDERDATE                 | Date of the order                     |
| STATUS                    | Current status of the order           |
| QTR\_ID                   | Quarter of the order                  |
| MONTH\_ID                 | Month number of the order             |
| YEAR\_ID                  | Year of the order                     |
| PRODUCTLINE               | Category of the product               |
| MSRP                      | Manufacturer's suggested retail price |
| PRODUCTCODE               | Unique product identifier             |
| CUSTOMERNAME              | Name of the customer                  |
| PHONE                     | Customer phone number                 |
| ADDRESSLINE1/2            | Customer address                      |
| CITY                      | City of the customer                  |
| STATE                     | State of the customer                 |
| POSTALCODE                | Postal code                           |
| COUNTRY                   | Country of the customer               |
| TERRITORY                 | Sales territory                       |
| CONTACTFIRSTNAME/LASTNAME | Customer contact name                 |
| DEALSIZE                  | Size of the deal                      |


## Data Cleaning Process

**1. Load Data:** Data loaded into MySQL using LOAD DATA INFILE for structured exploration.

**2. Handling NULL and Missing Values:** All empty strings ('') were converted to NULL using NULLIF() for consistent handling of missing data.

````sql
UPDATE sales_data_sample
SET 
ORDERNUMBER = NULLIF(ORDERNUMBER,''),
QUANTITYORDERED = NULLIF(QUANTITYORDERED,''),
PRICEEACH = NULLIF(PRICEEACH,''),
ORDERLINENUMBER = NULLIF(ORDERLINENUMBER,''),
SALES = NULLIF(SALES,''),
ORDERDATE = NULLIF(ORDERDATE,''),
`STATUS` = NULLIF(`STATUS`,''),
QTR_ID = NULLIF(QTR_ID,''),
MONTH_ID = NULLIF(MONTH_ID,''),
YEAR_ID = NULLIF(YEAR_ID,''),
PRODUCTLINE = NULLIF(PRODUCTLINE,''),
MSRP = NULLIF(MSRP,''),
PRODUCTCODE = NULLIF(PRODUCTCODE,''),
CUSTOMERNAME = NULLIF(CUSTOMERNAME,''),
PHONE = NULLIF(PHONE,''),
ADDRESSLINE1 = NULLIF(ADDRESSLINE1,''),
ADDRESSLINE2 = NULLIF(ADDRESSLINE2,''),
CITY = NULLIF(CITY,''),
STATE = NULLIF(STATE,''),
POSTALCODE = NULLIF(POSTALCODE,''),
COUNTRY = NULLIF(COUNTRY,''),
TERRITORY = NULLIF(TERRITORY,''),
CONTACTLASTNAME = NULLIF(CONTACTLASTNAME,''),
CONTACTFIRSTNAME = NULLIF(CONTACTFIRSTNAME,''),
DEALSIZE = NULLIF(DEALSIZE,'');
````

Null percentages were also calculated to assess the extent of missing data per column.

````sql
SELECT 
COUNT(*) AS TOTAL_ROWS,
(COUNT(*) - COUNT(ORDERNUMBER)) * 100 / COUNT(*) AS ORDERNUMBER_NULL_PCT,
(COUNT(*) - COUNT(QUANTITYORDERED)) * 100 / COUNT(*) AS QUANTITYORDERED_NULL_PCT,
(COUNT(*) - COUNT(PRICEEACH)) * 100 / COUNT(*) AS PRICEEACH_NULL_PCT,
(COUNT(*) - COUNT(ORDERLINENUMBER)) * 100 / COUNT(*) AS ORDERLINENUMBER_NULL_PCT,
(COUNT(*) - COUNT(SALES)) * 100 / COUNT(*) AS SALES_NULL_PCT,
(COUNT(*) - COUNT(ORDERDATE)) * 100 / COUNT(*) AS ORDERDATE_NULL_PCT,
(COUNT(*) - COUNT(STATUS)) * 100 / COUNT(*) AS STATUS_NULL_PCT,
(COUNT(*) - COUNT(QTR_ID)) * 100 / COUNT(*) AS QTR_ID_NULL_PCT,
(COUNT(*) - COUNT(MONTH_ID)) * 100 / COUNT(*) AS MONTH_ID_NULL_PCT,
(COUNT(*) - COUNT(YEAR_ID)) * 100 / COUNT(*) AS YEAR_ID_NULL_PCT,
(COUNT(*) - COUNT(PRODUCTLINE)) * 100 / COUNT(*) AS PRODUCTLINE_NULL_PCT,
(COUNT(*) - COUNT(MSRP)) * 100 / COUNT(*) AS MSRP_NULL_PCT,
(COUNT(*) - COUNT(PRODUCTCODE)) * 100 / COUNT(*) AS PRODUCTCODE_NULL_PCT,
(COUNT(*) - COUNT(CUSTOMERNAME)) * 100 / COUNT(*) AS CUSTOMERNAME_NULL_PCT,
(COUNT(*) - COUNT(PHONE)) * 100 / COUNT(*) AS PHONE_NULL_PCT,
(COUNT(*) - COUNT(ADDRESSLINE1)) * 100 / COUNT(*) AS ADDRESSLINE1_NULL_PCT,
(COUNT(*) - COUNT(ADDRESSLINE2)) * 100 / COUNT(*) AS ADDRESSLINE2_NULL_PCT,
(COUNT(*) - COUNT(CITY)) * 100 / COUNT(*) AS CITY_NULL_PCT,
(COUNT(*) - COUNT(STATE)) * 100 / COUNT(*) AS STATE_NULL_PCT,
(COUNT(*) - COUNT(POSTALCODE)) * 100 / COUNT(*) AS POSTALCODE_NULL_PCT,
(COUNT(*) - COUNT(COUNTRY)) * 100 / COUNT(*) AS COUNTRY_NULL_PCT,
(COUNT(*) - COUNT(TERRITORY)) * 100 / COUNT(*) AS TERRITORY_NULL_PCT,
(COUNT(*) - COUNT(CONTACTLASTNAME)) * 100 / COUNT(*) AS CONTACTLASTNAME_NULL_PCT,
(COUNT(*) - COUNT(CONTACTFIRSTNAME)) * 100 / COUNT(*) AS CONTACTFIRSTNAME_NULL_PCT,
(COUNT(*) - COUNT(DEALSIZE)) * 100 / COUNT(*) AS DEALSIZE_NULL_PCT
FROM sales_data_sample;
````

### 3. Standardizing Numeric Columns

Columns like ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, and SALES were checked for non-numeric values and converted to appropriate numeric types.
````sql
ALTER TABLE sales_data_sample
MODIFY COLUMN ORDERNUMBER INT;
ALTER TABLE sales_data_sample
MODIFY COLUMN QUANTITYORDERED INT;
ALTER TABLE sales_data_sample
MODIFY COLUMN PRICEEACH FLOAT;
ALTER TABLE sales_data_sample
MODIFY COLUMN ORDERLINENUMBER INT;
ALTER TABLE sales_data_sample
MODIFY COLUMN SALES FLOAT;
````

### 3. Standardizing Dates

The ORDERDATE column contained inconsistent formats. The SUBSTRING_INDEX function and STR_TO_DATE were used to standardize dates.

````sql
SELECT ORDERDATE,
STR_TO_DATE(SUBSTRING_INDEX(ORDERDATE, ' ', 1), '%m/%d/%Y') AS clean_ORDERDATE
FROM sales_data_sample
WHERE ORDERDATE IS NULL;

ALTER TABLE sales_data_sample
ADD COLUMN RAW_ORDERDATE VARCHAR(20);

UPDATE sales_data_sample
SET RAW_ORDERDATE = ORDERDATE;

SELECT RAW_ORDERDATE FROM sales_data_sample;

UPDATE sales_data_sample
SET ORDERDATE = STR_TO_DATE(SUBSTRING_INDEX(ORDERDATE, ' ', 1), '%m/%d/%Y');
````
A new column, Month_Name, was derived for easier month-based analysis:

````sql
SELECT ORDERDATE,MONTH_ID
FROM sales_data_sample;

SELECT ORDERDATE,
MONTHNAME(ORDERDATE) AS Month_Name
FROM sales_data_sample;

ALTER TABLE sales_data_sample
ADD COLUMN Month_Name VARCHAR(20);

UPDATE sales_data_sample
SET Month_Name = MONTHNAME(ORDERDATE);

SELECT Month_Name FROM sales_data_sample;
````

### 4. Standardizing Categorical Columns
**Status**

Order statuses were Categorized into three main categories:

 - **In Progress:** IN PROCESS, ON HOLD

 - **Completed:** SHIPPED, RESOLVED

 - **Cancelled:** DISPUTED, CANCELLED

````sql
UPDATE sales_data_sample
SET STATUS = CASE
    WHEN STATUS IN ('IN PROCESS','ON HOLD') THEN 'In Progress'
    WHEN STATUS IN ('SHIPPED','RESOLVED') THEN 'Completed'
    WHEN STATUS IN ('DISPUTED','CANCELLED') THEN 'Cancelled'
    ELSE STATUS
END;
````

### 6. Standardizing State & City

 - Standardized city names, e.g., NYC → New York.

````sql
UPDATE sales_data_sample
SET STATE = CASE 
    WHEN STATE = 'NY' THEN 'New York'
    WHEN STATE = 'CA' THEN 'California'
	WHEN STATE = 'NJ' THEN 'New Jersey'
	WHEN STATE = 'CT' THEN 'Connecticut'
    WHEN STATE = 'MA' THEN 'Massachusetts'
    WHEN STATE = 'PA' THEN 'Pennsylvania'
	WHEN STATE = 'NSW' THEN 'New South Wales'
	WHEN STATE = 'Queensland' THEN 'Queensland'
	WHEN STATE = 'BC' THEN 'British Columbia'
	WHEN STATE = 'Tokyo' THEN 'Tokyo Metropolis'
	WHEN STATE = 'NH' THEN 'New Hampshire'
	WHEN STATE = 'Quebec' THEN 'Quebec'
	WHEN STATE = 'Osaka' THEN 'Osaka Prefecture'
	WHEN STATE = 'Isle of Wight' THEN 'Isle of Wight'
	WHEN STATE = 'NV' THEN 'Nevada'
    ELSE STATE
END;
````

 - Mapped abbreviations and missing states using city names.
Here all state with null values are derived by getting the names of the city from the city column and then comaring it with the state column, by using this i can easily derive the state name from the city where the state is null. this is fully successfull because all city column are give.

