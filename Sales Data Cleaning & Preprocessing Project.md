# Sales Data Cleaning & Preprocessing Project

##  Project Overview
This project demonstrates a comprehensive data cleaning and preprocessing workflow using a sample sales dataset. The dataset contains order, customer, product, and geographical information. The goal is to clean, standardize, and validate the data to prepare it for data analysis, visualization, and reporting.

### Key objectives:
 - Identify and handle missing, blank, and malformed data.

 - Standardize categorical and date fields.

 - Create derived columns for better usability.

 - Detect and report duplicate records.

### Dataset
The dataset sales_data_sample.csv includes the following columns:

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
