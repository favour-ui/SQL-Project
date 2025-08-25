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

 - **Mapped abbreviations and missing states using city names:**
Here all state with null values are derived by getting the names of the city from the city column and then comaring it with the state column, by using this i can easily derive the state name from the city where the state is null. this is fully successfull because all city column are give.

| Before                | After
| -------------------------  | ------------------------------------- |
|  <img width="209" height="188" alt="state before" src="https://github.com/user-attachments/assets/29e92f28-e676-414c-93d7-ca100f05a03b" />               | <img width="146" height="179" alt="after state" src="https://github.com/user-attachments/assets/4de9144f-0fe2-4dcb-b132-55f6d3d7e10b" />                |

````sql
UPDATE sales_data_sample
SET STATE = CASE 
WHEN State IS NULL AND City = 'NYC' THEN 'New York'
WHEN State IS NULL AND City = 'Reims' THEN 'Grand Est'
WHEN State IS NULL AND City = 'Paris' THEN 'Île-de-France'
WHEN State IS NULL AND City = 'Pasadena' THEN 'California'
WHEN State IS NULL AND City = 'San Francisco' THEN 'California'
WHEN State IS NULL AND City = 'Burlingame' THEN 'California'
WHEN State IS NULL AND City = 'Lille' THEN 'Hauts-de-France'
WHEN State IS NULL AND City = 'Bergen' THEN 'Vestland'
WHEN State IS NULL AND City = 'Melbourne' THEN 'Victoria'
WHEN State IS NULL AND City = 'Newark' THEN 'New Jersey'
WHEN State IS NULL AND City = 'Bridgewater' THEN 'Connecticut'
WHEN State IS NULL AND City = 'Nantes' THEN 'Pays de la Loire'
WHEN State IS NULL AND City = 'Cambridge' THEN 'Massachusetts'
WHEN State IS NULL AND City = 'Helsinki' THEN 'Uusimaa'
WHEN State IS NULL AND City = 'Stavern' THEN 'Vestfold'
WHEN State IS NULL AND City = 'Allentown' THEN 'Pennsylvania'
WHEN State IS NULL AND City = 'Salzburg' THEN 'Salzburg'
WHEN State IS NULL AND City = 'Chatswood' THEN 'New South Wales'
WHEN State IS NULL AND City = 'New Bedford' THEN 'Massachusetts'
WHEN State IS NULL AND City = 'Liverpool' THEN 'England'
WHEN State IS NULL AND City = 'Madrid' THEN 'Community of Madrid'
WHEN State IS NULL AND City = 'Lule' THEN 'Norrbotten County'
WHEN State IS NULL AND City = 'Singapore' THEN 'Singapore'
WHEN State IS NULL AND City = 'South Brisbane' THEN 'Queensland'
WHEN State IS NULL AND City = 'Philadelphia' THEN 'Pennsylvania'
WHEN State IS NULL AND City = 'Lyon' THEN 'Auvergne-Rhône-Alpes'
WHEN State IS NULL AND City = 'Vancouver' THEN 'British Columbia'
WHEN State IS NULL AND City = 'Burbank' THEN 'California'
WHEN State IS NULL AND City = 'New Haven' THEN 'Connecticut'
WHEN State IS NULL AND City = 'Minato-ku' THEN 'Tokyo Metropolis'
WHEN State IS NULL AND City = 'Torino' THEN 'Piedmont'
WHEN State IS NULL AND City = 'Boras' THEN 'Västra Götaland County'
WHEN State IS NULL AND City = 'Versailles' THEN 'Île-de-France'
WHEN State IS NULL AND City = 'San Rafael' THEN 'California'
WHEN State IS NULL AND City = 'Nashua' THEN 'New Hampshire'
WHEN State IS NULL AND City = 'Brickhaven' THEN 'Massachusetts'
WHEN State IS NULL AND City = 'North Sydney' THEN 'New South Wales'
WHEN State IS NULL AND City = 'Montreal' THEN 'Quebec'
WHEN State IS NULL AND City = 'Osaka' THEN 'Osaka Prefecture'
WHEN State IS NULL AND City = 'White Plains' THEN 'New York'
WHEN State IS NULL AND City = 'Kobenhavn' THEN 'Copenhagen'
WHEN State IS NULL AND City = 'London' THEN 'England'
WHEN State IS NULL AND City = 'Toulouse' THEN 'Occitanie'
WHEN State IS NULL AND City = 'Barcelona' THEN 'Catalonia'
WHEN State IS NULL AND City = 'Los Angeles' THEN 'California'
WHEN State IS NULL AND City = 'San Diego' THEN 'California'
WHEN State IS NULL AND City = 'Bruxelles' THEN 'Brussels'
WHEN State IS NULL AND City = 'Tsawassen' THEN 'British Columbia'
WHEN State IS NULL AND City = 'Boston' THEN 'Massachusetts'
WHEN State IS NULL AND City = 'Cowes' THEN 'Isle of Wight'
WHEN State IS NULL AND City = 'Oulu' THEN 'North Ostrobothnia'
WHEN State IS NULL AND City = 'San Jose' THEN 'California'
WHEN State IS NULL AND City = 'Graz' THEN 'Styria'
WHEN State IS NULL AND City = 'Makati City' THEN 'Metro Manila'
WHEN State IS NULL AND City = 'Marseille' THEN 'Provence-Alpes-Côte d’Azur'
WHEN State IS NULL AND City = 'Koln' THEN 'North Rhine-Westphalia'
WHEN State IS NULL AND City = 'Gensve' THEN 'Geneva'
WHEN State IS NULL AND City = 'Reggio Emilia' THEN 'Emilia-Romagna'
WHEN State IS NULL AND City = 'Frankfurt' THEN 'Hesse'
WHEN State IS NULL AND City = 'Espoo' THEN 'Uusimaa'
WHEN State IS NULL AND City = 'Dublin' THEN 'Leinster'
WHEN State IS NULL AND City = 'Manchester' THEN 'England'
WHEN State IS NULL AND City = 'Aaarhus' THEN 'Central Denmark Region'
WHEN State IS NULL AND City = 'Glendale' THEN 'California'
WHEN State IS NULL AND City = 'Sevilla' THEN 'Andalusia'
WHEN State IS NULL AND City = 'Brisbane' THEN 'Queensland'
WHEN State IS NULL AND City = 'Strasbourg' THEN 'Grand Est'
WHEN State IS NULL AND City = 'Las Vegas' THEN 'Nevada'
WHEN State IS NULL AND City = 'Oslo' THEN 'Oslo County'
WHEN State IS NULL AND City = 'Bergamo' THEN 'Lombardy'
WHEN State IS NULL AND City = 'Glen Waverly' THEN 'Victoria'
WHEN State IS NULL AND City = 'Munich' THEN 'Bavaria'
WHEN State IS NULL AND City = 'Charleroi' THEN 'Wallonia'
ELSE State 
END;
````



### 7. Creating Fullname Columns

FULL_NAME column created by concatenating first and last names:

````sql
SELECT CONTACTFIRSTNAME,CONTACTLASTNAME,
TRIM(CONCAT(CONTACTFIRSTNAME,' ', CONTACTLASTNAME))
FROM sales_data_sample;

ALTER TABLE sales_data_sample
ADD COLUMN FULL_NAME VARCHAR(100);

UPDATE sales_data_sample
SET FULL_NAME = TRIM(CONCAT(CONTACTFIRSTNAME,' ', CONTACTLASTNAME));

SELECT FULL_NAME FROM sales_data_sample;
````

### 8. Duplicate Detection

Checked for duplicates at multiple levels:

 1. Customer + Order + Product

```sql
SELECT CUSTOMERNAME, ORDERDATE, PRODUCTCODE, COUNT(*) AS count
FROM sales_data_sample
GROUP BY CUSTOMERNAME, ORDERDATE, PRODUCTCODE
HAVING COUNT(*) > 1;
````

2. Order + Line Number

````sql
SELECT ORDERNUMBER, ORDERLINENUMBER, COUNT(*) AS count
FROM sales_data_sample
GROUP BY ORDERNUMBER, ORDERLINENUMBER
HAVING COUNT(*) > 1;
````

3.Order + Productcode

```sql
SELECT ORDERNUMBER, PRODUCTCODE, COUNT(*) AS count
FROM sales_data_sample
GROUP BY ORDERNUMBER, PRODUCTCODE
HAVING COUNT(*) > 1;
````

### Key Outcomes

 - Missing and malformed values were handled.

 - Numeric, categorical, and date columns standardized.

 - Derived columns (FULL_NAME, Month_Name) added for easier analysis.

 - Duplicate records identified for review or removal.

 - Data is now ready for visualization, analysis, and reporting.

### Skills Demonstrated

 - SQL Data Cleaning & Transformation

 - Handling NULL and inconsistent values

 - Standardizing categorical and date fields

 - Duplicate detection & reporting

 - Creating derived fields for analysis

 - Preparing data for Analytics and BI projects

### ✅ Conclusion:
This project demonstrates a full-fledged data cleaning workflow, converting raw sales data into a clean, structured dataset suitable for analysis, dashboards, and machine learning tasks.

