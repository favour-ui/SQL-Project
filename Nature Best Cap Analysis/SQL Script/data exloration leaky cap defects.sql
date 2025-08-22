select * from factproductionevent;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/FactProductionEvent.csv'
INTO TABLE factproductionevent
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM dimcapbatch
WHERE CapBatchSK = '';

SELECT * FROM dimdate
WHERE DateKey = '';

SELECT * FROM dimjuicebatch
WHERE JuiceBatchSK = '';

SELECT * FROM dimmachine;

SELECT * FROM dimnozzle;

SELECT * FROM dimoperator;

SELECT * FROM dimsupplier;

SELECT * FROM factproductionevent;

-- CHANGING ALL EMPTY COLUN TO NULLS

update factproductionevent
set 
ProductionEventSK  = nullif(ProductionEventSK,''),
BottleID_Natural = nullif(BottleID_Natural, ''),
`Timestamp` = nullif(`Timestamp`, ''),
DateKey = nullif(DateKey, ''),
OperatorSK = nullif(OperatorSK, ''),
LineID = nullif(LineID, ''),
Product = nullif(Product, ''),
shift = nullif(shift, ''),
OperatorID_Natural = nullif(OperatorID_Natural, ''),
OperatorRole = nullif(OperatorRole, ''),
FillerMachineSK = nullif(FillerMachineSK, ''),
CapperMachineSK = nullif(CapperMachineSK, ''),
FillerMachineID_Natural = nullif(FillerMachineID_Natural, ''),
CapperMachineID_Natural = nullif(CapperMachineID_Natural, ''),
FillerNozzleSK = nullif(FillerNozzleSK, ''),
JuiceBatchSK = nullif(JuiceBatchSK, ''),
BottleBatchSK = nullif(BottleBatchSK, ''),
CapBatchSK = nullif(CapBatchSK, ''),
TargetFillVolume_ml = nullif(TargetFillVolume_ml, ''),
ActualFillVolume_ml = nullif(ActualFillVolume_ml, ''),
FillSpeedBottlesPerMin_Set = nullif(FillSpeedBottlesPerMin_Set, ''),
FillSpeedBottlesPerMin_Actual = nullif(FillSpeedBottlesPerMin_Actual, ''),
JuiceTemperatureC_In = nullif(JuiceTemperatureC_In, ''),
JuiceViscosity_cPs_Actual = nullif(JuiceViscosity_cPs_Actual, ''),
TargetCapTorque_Nm= nullif(TargetCapTorque_Nm, ''),
ActualCapTorque_Nm = nullif(ActualCapTorque_Nm, ''),
CapHopperLevel_Percent = nullif(CapHopperLevel_Percent, ''),
AmbientTemperatureC_Line = nullif(AmbientTemperatureC_Line, ''),
AmbientHumidityPercent_Line = nullif(AmbientHumidityPercent_Line, ''),
Defect_Type = nullif(Defect_Type, ''),
LeakTestResult = nullif(LeakTestResult, ''),
UnderfillAmount_ml = nullif(UnderfillAmount_ml, ''),
FillerMaintenanceLast_Days_Snapshot = nullif(FillerMaintenanceLast_Days_Snapshot, ''),
CapperMaintenanceLast_Days_Snapshot = nullif(CapperMaintenanceLast_Days_Snapshot, '');

select *
from factproductionevent
where CapperMachineSK = '';

-- COUNTIMH EACH ROWS TO KNOW THOSE WHICH ARE HAVING NULLS

SELECT 
  COUNT(*) AS total_rows,
  count(ProductionEventSK) as ProductionEventSK_null,
 COUNT(BottleID_Natural) AS BottleID_Natural_null,
   COUNT(`Timestamp`) AS Timestamp_null,
   COUNT(operatorSK) AS operatorSK_null,
   COUNT(LineID) AS LineID_null,
   COUNT(product) AS product_null,
   COUNT(shift) AS shift_null,
   COUNT(OperatorID_Natural) AS OperatorID_Natural_null,
   COUNT(OperatorRole) AS OperatorRole_null,
   COUNT(JuiceBatchSK) AS JuiceBatchSK_null,
   COUNT(BottleBatchSK) AS BottleBatchSK_null,
    COUNT(AmbientHumidityPercent_Line) AS AmbientHumidityPercent_Line_null,
    COUNT(AmbientTemperatureC_Line) AS AmbientTemperatureC_Line_null,
    COUNT(JuiceTemperatureC_In) AS JuiceTemperatureC_In_null,
    COUNT(Defect_Type) AS Defect_Type_null,
    COUNT(LeakTestResult) AS LeakTestResult_null,
    COUNT(UnderfillAmount_ml) AS UnderfillAmount_ml_null,
    COUNT(CapperMachineSK) AS CapperMachineSK_NULL,
    COUNT(CapperMachineID_Natural) AS CapperMachineID_Natural_NULL,
    COUNT(CapBatchSK) AS CapBatchSK_NULL,
    COUNT(TargetCapTorque_Nm) AS TargetCapTorque_Nm_NULL,
    COUNT(ActualCapTorque_Nm) AS ActualCapTorque_Nm_NULL,
    COUNT(CapHopperLevel_Percent) AS CapHopperLevel_Percent_NULL,
    COUNT(CapHopperLevel_Percent) AS CapHopperLevel_Percent_NULL,
    COUNT(CapperMaintenanceLast_Days_Snapshot) AS CapperMaintenanceLast_Days_Snapshot_NULL
  from factproductionevent;

-- FINDING EACH PERCENTANGR TO KNOW THE PERCENT OF NULL

SELECT 
  COUNT(*) AS total_rows,
  (COUNT(*) - COUNT(ProductionEventSK)) * 100.0 / COUNT(*) AS ProductionEventSK_null_pct,
  (COUNT(*) - COUNT(BottleID_Natural)) * 100.0 / COUNT(*) AS BottleID_Natural_null_pct,
  (COUNT(*) - COUNT(`Timestamp`)) * 100.0 / COUNT(*) AS Timestamp_null_pct,
  (COUNT(*) - COUNT(operatorSK)) * 100.0 / COUNT(*) AS operatorSK_null_pct,
  (COUNT(*) - COUNT(LineID)) * 100.0 / COUNT(*) AS LineID_null_pct,
  (COUNT(*) - COUNT(product)) * 100.0 / COUNT(*) AS product_null_pct,
  (COUNT(*) - COUNT(shift)) * 100.0 / COUNT(*) AS shift_null_pct,
  (COUNT(*) - COUNT(OperatorID_Natural)) * 100.0 / COUNT(*) AS OperatorID_Natural_null_pct,
  (COUNT(*) - COUNT(OperatorRole)) * 100.0 / COUNT(*) AS OperatorRole_null_pct,
  (COUNT(*) - COUNT(JuiceBatchSK)) * 100.0 / COUNT(*) AS JuiceBatchSK_null_pct,
  (COUNT(*) - COUNT(BottleBatchSK)) * 100.0 / COUNT(*) AS BottleBatchSK_null_pct,
  (COUNT(*) - COUNT(JuiceTemperatureC_In)) * 100.0 / COUNT(*) AS JuiceTemperatureC_In_null_pct,
  (COUNT(*) - COUNT(AmbientHumidityPercent_Line)) * 100.0 / COUNT(*) AS AmbientHumidityPercent_Line_null_pct,
  (COUNT(*) - COUNT(AmbientTemperatureC_Line)) * 100.0 / COUNT(*) AS AmbientTemperatureC_Line_null_pct,
  (COUNT(*) - COUNT(Defect_Type)) * 100.0 / COUNT(*) AS Defect_Type_null_pct,
  (COUNT(*) - COUNT(LeakTestResult)) * 100.0 / COUNT(*) AS LeakTestResult_null_pct,
  (COUNT(*) - COUNT(UnderfillAmount_ml)) * 100.0 / COUNT(*) AS UnderfillAmount_ml_null_pct,
  (COUNT(*) - COUNT(CapperMachineSK)) * 100.0 / COUNT(*)  AS CapperMachineSK_NULL,
   (COUNT(*) - COUNT(CapperMachineID_Natural)) * 100.0 / COUNT(*) AS CapperMachineID_Natural_null_pct,
  (COUNT(*) - COUNT(CapBatchSK)) * 100.0 / COUNT(*) AS CapBatchSK_null_pct,
  (COUNT(*) - COUNT(TargetCapTorque_Nm)) * 100.0 / COUNT(*) AS TargetCapTorque_Nm_null_pct,
  (COUNT(*) - COUNT(ActualCapTorque_Nm)) * 100.0 / COUNT(*) AS ActualCapTorque_Nm_null_pct,
  (COUNT(*) - COUNT(CapHopperLevel_Percent)) * 100.0 / COUNT(*) AS CapHopperLevel_Percent_null_pct,
   (COUNT(*) - COUNT(CapperMaintenanceLast_Days_Snapshot)) * 100.0 / COUNT(*) AS CapperMaintenanceLast_Days_Snapshot_null_pct
FROM FactProductionEvent;

SELECT BottleID_Natural, COUNT(*) 
FROM FactProductionEvent
GROUP BY BottleID_Natural
HAVING COUNT(*) > 1;

SELECT ProductionEventSK, COUNT(*) 
FROM FactProductionEvent
GROUP BY ProductionEventSK
HAVING COUNT(*) > 1;

-- Change data types for consistency

DESCRIBE FactProductionEvent;

select distinct CapBatchSK
from factproductionevent;

ALTER TABLE FactProductionEvent
MODIFY COLUMN CapBatchSK int;

-- Time range of the data
SELECT MIN(DateKey) AS StartDate, MAX(DateKey) AS EndDate
FROM FactProductionEvent;

SELECT distinct DateKey 
FROM factproductionevent;

SELECT DateKey 
FROM factproductionevent
WHERE DateKey IS NULL;

SELECT 
DATEKEY,
str_to_date(DATEKEY,'%Y%m%d') as Proper_date
from factproductionevent;

ALTER TABLE factproductionevent
ADD COLUMN Proper_date DATE;

update factproductionevent
SET Proper_date = str_to_date(Datekey,'%Y%m%d');

show processlist;

SELECT Datekey
FROM factproductionevent;

SELECT Proper_date
FROM factproductionevent;

ALTER TABLE factproductionevent
DROP COLUMN DATEKEY;

ALTER TABLE factproductionevent change Proper_date Datekey DATE;


SELECT DateKey FROM factproductionevent
WHERE DateKey IS NULL;

SELECT FullDate AS DATE_COLUMN, P.DateKey AS PRODUCTION_DATE
FROM dimdate D LEFT JOIN factproductionevent P
ON D.DateKey = P.DateKey
ORDER BY D.DateKey;
-- TO KNOW DAYS OF NO PRODUCTION CHECKING FOR MISSING DAYS 

SELECT * FROM dimdate;

SELECT d.FullDate AS DATE_COLUMN,d.DAYNAME,f.DateKey FROM dimdate d
LEFT JOIN factproductionevent f
ON d.DateKey = f.DateKey
WHERE f.DateKey IS NULL
ORDER BY d.DateKey;

-- WORKING ON DATE KEY ON DIMDATE

SELECT DATEKEY FROM DIMDATE;
SELECT * FROM DIMDATE;

SELECT DATEKEY,str_to_date(DATEKEY,'%Y%m%d') AS PROPERDATE
FROM dimdate;

UPDATE dimdate
SET PROPERDATE = str_to_date(DATEKEY,'%Y%m%d');

ALTER TABLE DIMDATE 
ADD COLUMN PROPERDATE DATE;

SELECT PROPERDATE FROM dimdate;

ALTER TABLE DIMDATE 
DROP COLUMN DATEKEY;

ALTER TABLE dimdate CHANGE PROPERDATE DATEKEY DATE;

SELECT DATEKEY FROM dimdate;



-- DATA CLEANING PROCESS
-- WORKING ON TIMESTAMP

SELECT `Timestamp`, STR_TO_DATE(`Timestamp`, '%Y-%m-%d %H:%i:%s') AS clean_timestamp
FROM FactProductionEvent
WHERE STR_TO_DATE(`Timestamp`, '%Y-%m-%d %H:%i:%s') IS NULL;

SELECT DISTINCT `Timestamp` FROM factproductionevent;

ALTER TABLE FactProductionEvent
ADD COLUMN clean_timestamp DATETIME;

ALTER TABLE FactProductionEvent
MODIFY clean_timestamp VARCHAR(50);

-- CLEAN: 'TS2025-07-01 08:00:00'
SELECT Timestamp, 
SUBSTRING(`Timestamp`,5,19)
FROM FactProductionEvent
WHERE Timestamp LIKE '%TS%';

SELECT timestamp, replace(REPLACE(TIMESTAMP,'.','-'),';','-')
FROM factproductionevent
WHERE str_to_date(replace(REPLACE(TIMESTAMP,'.','-'),';','-'),'%Y-%m-%d $H:$i:$s') IS NULL;

UPDATE factproductionevent
SET CLEAN_TIMESTAMP = 
  CASE 
     WHEN `timestamp` LIKE '%TS%' THEN TRIM(SUBSTRING(`Timestamp`,5,19))
     WHEN `timestamp` LIKE '%.%' THEN TRIM(replace(REPLACE(`TIMESTAMP`,'.','-'),';','-'))
     WHEN `timestamp` = 'unknowntimestamp' OR timestamp LIKE '%MM%' THEN null
     ELSE `timestamp`
     END ;

SHOW processlist;
KILL 10;

-- TESTING TO CONFIME TIMESTAMP
SELECT `Timestamp`, CAST(`clean_timestamp` AS DATETIME) AS cast_timestamp
FROM FactProductionEvent
WHERE STR_TO_DATE(`clean_timestamp`, '%Y-%m-%d %H:%i:%s') IS NULL;

SELECT TRIM(`clean_timestamp`)  FROM factproductionevent
WHERE STR_TO_DATE(`clean_timestamp`, '%Y-%m-%d %H:%i:%s') IS NULL;

SELECT CLEAN_TIMESTAMP FROM factproductionevent
WHERE CLEAN_TIMESTAMP IS NULL;

SELECT CLEAN_TIMESTAMP FROM factproductionevent
WHERE CLEAN_TIMESTAMP = '';

ALTER TABLE factproductionevent
DROP COLUMN `Timestamp`;

ALTER TABLE factproductionevent CHANGE CLEAN_TIMESTAMP `Timestamp` datetime;

SELECT `Timestamp` FROM factproductionevent;

SELECT `Timestamp` FROM factproductionevent
WHERE STR_TO_DATE(`Timestamp`, '%Y-%m-%d %H:%i:%s') IS NULL;

DESCRIBE factproductionevent;

-- VALIDATE JuiceTemperatureC_In

SELECT JuiceTemperatureC_In FROM factproductionevent
WHERE JuiceTemperatureC_In IS NULL;

SELECT DISTINCT JuiceTemperatureC_In FROM factproductionevent;

SELECT DISTINCT JuiceTemperatureC_In
FROM factproductionevent
WHERE JuiceTemperatureC_In IS NULL 
   OR JuiceTemperatureC_In = ''
   OR JuiceTemperatureC_In NOT REGEXP '^[-]?[0-9]+(\.[0-9]+)?$';
   
   
ALTER TABLE factproductionevent
ADD COLUMN RAW_JuiceTemperatureC_In varchar(50);

UPDATE factproductionevent
SET RAW_JuiceTemperatureC_In = JuiceTemperatureC_In;

UPDATE factproductionevent
SET JuiceTemperatureC_In = NULL
WHERE LOWER(TRIM(JuiceTemperatureC_In)) IN ('WAY TOO HOT','SENSOR_BROKEN','COLD!','HOT!');

describe factproductionevent;

ALTER TABLE factproductionevent
MODIFY COLUMN JuiceTemperatureC_In FLOAT;

-- VALIDATE AmbientHumidityPercent_Line

SELECT AmbientHumidityPercent_Line FROM factproductionevent;
   
SELECT distinct AmbientHumidityPercent_Line
FROM factproductionevent
WHERE AmbientHumidityPercent_Line IS NULL
OR AmbientHumidityPercent_Line = ''
OR AmbientHumidityPercent_Line NOT REGEXP '^[-]?[0-9]+(\.[0-9]+)?$';

ALTER TABLE factproductionevent
MODIFY COLUMN AmbientHumidityPercent_Line FLOAT;

-- VALIDATE ActualCapTorque_Nm

SELECT ActualCapTorque_Nm FROM factproductionevent;

SELECT DISTINCT ActualCapTorque_Nm 
FROM factproductionevent
WHERE ActualCapTorque_Nm IS NULL
OR ActualCapTorque_Nm = ''
OR ActualCapTorque_Nm NOT REGEXP '^[-]?[0-9]+(\.[0-9]+)?$';

ALTER TABLE factproductionevent
ADD COLUMN RAW_ActualCapTorque_Nm varchar(50);

UPDATE factproductionevent
SET RAW_ActualCapTorque_Nm = ActualCapTorque_Nm;

UPDATE factproductionevent
SET ActualCapTorque_Nm = NULL
WHERE LOWER(TRIM(ActualCapTorque_Nm)) IN ('sensor_broken');

describe factproductionevent;

ALTER TABLE factproductionevent
MODIFY COLUMN ActualCapTorque_Nm FLOAT;

-- VALIDATE CapHopperLevel_Percent
SELECT CapHopperLevel_Percent FROM factproductionevent;


SELECT distinct CapHopperLevel_Percent FROM factproductionevent
WHERE CapHopperLevel_Percent IS NULL 
OR CapHopperLevel_Percent =''
OR CapHopperLevel_Percent NOT REGEXP '^[-]?[0-9]+(\.[0-9]+)?$';

ALTER TABLE factproductionevent
MODIFY COLUMN CapHopperLevel_Percent FLOAT;

describe factproductionevent;

-- VALIDATE TargetCapTorque_Nm
SELECT TargetCapTorque_Nm FROM factproductionevent
WHERE TargetCapTorque_Nm IS NULL;

-- VALIDATE CapBatchSK
SELECT DISTINCT CapBatchSK FROM factproductionevent;

ALTER TABLE factproductionevent
MODIFY COLUMN CapBatchSK INT;

DESCRIBE factproductionevent;


-- VALIDATE BottleID_Natural
SELECT BottleID_Natural FROM factproductionevent;

-- VALIDATE operatorSK
SELECT DISTINCT operatorSK FROM factproductionevent;

DESCRIBE factproductionevent;

ALTER TABLE factproductionevent
MODIFY COLUMN operatorSK INT;

-- VALIDATE LineID
SELECT DISTINCT LineID FROM factproductionevent;

-- VALIDATE product
SELECT DISTINCT product FROM factproductionevent;

-- VALIDATE OperatorID_Natural
SELECT DISTINCT OperatorID_Natural FROM factproductionevent;

-- VALIDATE OperatorRole
SELECT DISTINCT OperatorRole FROM factproductionevent;

-- VALIDATE JuiceBatchSK
SELECT DISTINCT JuiceBatchSK FROM factproductionevent;

-- VALIDATE BottleBatchSK
SELECT DISTINCT BOTTLEBATCHSK FROM factproductionevent;
DESCRIBE factproductionevent;

ALTER TABLE factproductionevent
MODIFY COLUMN BOTTLEBATCHSK INT;

-- VALIDATE AmbientTemperatureC_Line
SELECT DISTINCT AmbientTemperatureC_Line FROM factproductionevent;

SELECT * FROM factproductionevent;

SELECT DISTINCT AmbientTemperatureC_Line 
FROM factproductionevent
WHERE AmbientTemperatureC_Line IS NULL 
OR AmbientTemperatureC_Line = ''
OR AmbientTemperatureC_Line NOT REGEXP '^[-]?[0-9]+(\.[0-9]+)?$';


ALTER TABLE factproductionevent
ADD COLUMN RAW_AmbientTemperatureC_Line varchar(50);

UPDATE factproductionevent
SET RAW_AmbientTemperatureC_Line = AmbientTemperatureC_Line;

-- CHECKING BEFORE RUNNING THE UPDATE 

SELECT AmbientTemperatureC_Line FROM factproductionevent
WHERE AmbientTemperatureC_Line = '25.0';

SELECT COUNT(*) AS rows_to_update
FROM factproductionevent
WHERE AmbientTemperatureC_Line = '25 C';

SELECT 
       AmbientTemperatureC_Line AS old_value,
       '25.0' AS new_value
FROM factproductionevent
WHERE AmbientTemperatureC_Line = '25 C';

UPDATE factproductionevent
SET AmbientTemperatureC_Line = '25.0'
WHERE AmbientTemperatureC_Line = '25 C';

SELECT DISTINCT AmbientTemperatureC_Line AS OLD_VALUE,
null AS NEW_VALUE
FROM factproductionevent
WHERE LOWER(TRIM(AmbientTemperatureC_Line)) IN ('sensor_err', 
 'fluctuating');
 
 UPDATE factproductionevent
 SET AmbientTemperatureC_Line = NULL 
WHERE LOWER(TRIM(AmbientTemperatureC_Line)) IN ('sensor_err', 
 'fluctuating');
 
 describe factproductionevent;
 
 ALTER TABLE factproductionevent
 MODIFY COLUMN AmbientTemperatureC_Line FLOAT;



-- VALIDATE CapperMachineSK
SELECT DISTINCT  CapperMachineSK FROM factproductionevent;

SELECT CapperMachineSK FROM factproductionevent
WHERE CapperMachineSK IS NULL
OR CapperMachineSK = ''
OR CapperMachineSK NOT REGEXP '^[-]?[0-9]+(\.[0-9]+)?$';

-- VALIDATE CapperMachineID_Natural
SELECT DISTINCT CapperMachineID_Natural  FROM factproductionevent;

-- VALIDATE CapperMaintenanceLast_Days_Snapshot
SELECT DISTINCT CapperMaintenanceLast_Days_Snapshot  FROM factproductionevent;

SELECT CapperMaintenanceLast_Days_Snapshot FROM factproductionevent
WHERE CapperMaintenanceLast_Days_Snapshot IS NULL
OR CapperMaintenanceLast_Days_Snapshot = ''
OR CapperMaintenanceLast_Days_Snapshot NOT REGEXP '^[-]?[0-9]+(\.[0-9]+)?$';

-- STANDARDIZING TEXT COLUMNS



-- WORKING ON THE DEFECT TYPES
SELECT * FROM factproductionevent;
SELECT DISTINCT DEFECT_TYPE FROM factproductionevent;



SELECT DISTINCT CATEGORY FROM (
SELECT  DEFECT_TYPE,
  CASE 
     WHEN DEFECT_TYPE  IN ('Leaky_Cap','Cap Leak','leak_cap','LeakyCap','leaky cap') THEN 'LeakyCap'
     WHEN DEFECT_TYPE IN ('Underfilled','under fill','low fill') THEN 'Underfilled'
     WHEN DEFECT_TYPE IN ('Both','Underfill&Leak','both defects') THEN 'Both'
     WHEN DEFECT_TYPE IN ('None','N/A Defect',' nil ','  OK  ') THEN 'None'
  END AS CATEGORY
FROM factproductionevent
) t;

UPDATE factproductionevent
SET DEFECT_TYPE = CASE 
     WHEN DEFECT_TYPE  IN ('Leaky_Cap','Cap Leak','leak_cap','LeakyCap','leaky cap') THEN 'LeakyCap'
     WHEN DEFECT_TYPE IN ('Underfilled','under fill','low fill') THEN 'Underfilled'
     WHEN DEFECT_TYPE IN ('Both','Underfill&Leak','both defects') THEN 'Both'
     WHEN DEFECT_TYPE IN ('None','N/A Defect',' nil ','  OK  ') THEN 'None'
  END
WHERE Defect_Type IS NOT NULL;


-- WORKING ON LeakTestResult

SELECT DISTINCT LeakTestResult FROM factproductionevent;


SELECT DISTINCT LeakTestResult,
CASE  
    WHEN TRIM(LOWER(LeakTestResult)) IN ('Pass','pass ','Ok') THEN 'Pass'
    WHEN TRIM(LOWER(LeakTestResult)) IN ('Fail',' fail','Not Good') THEN 'Fail'
    ELSE LeakTestResult
END AS LEAKRESULT
FROM factproductionevent;


UPDATE factproductionevent
SET LeakTestResult = CASE  
    WHEN TRIM(LOWER(LeakTestResult)) IN ('Pass','pass ','Ok') THEN 'Pass'
    WHEN TRIM(LOWER(LeakTestResult)) IN ('Fail',' fail','Not Good') THEN 'Fail'
    ELSE LeakTestResult
END;

SELECT DISTINCT LeakTestResult FROM factproductionevent;

-- CHECKING FOR DUPLICATE AND REMOVING DUPLICATES

SELECT ProductionEventSK,BottleID_Natural,Timestamp, COUNT(*)
FROM FactProductionEvent
GROUP BY ProductionEventSK,BottleID_Natural,`Timestamp`
HAVING COUNT(*) > 1;

SELECT ProductionEventSK,BottleID_Natural,Timestamp FROM factproductionevent
WHERE ProductionEventSK IN (275543,256831,160069)
ORDER BY ProductionEventSK;

-- NOW CREATE INDEX TO QUICKEN THE UPDATE 

CREATE INDEX IDX_DUPLICATE ON factproductionevent (ProductionEventSK(100),BottleID_Natural(100),`Timestamp`);

SHOW INDEX FROM factproductionevent;


 -- DELETING ALL DUPLICATES

WITH CTE AS (
SELECT ProductionEventSK,BottleID_Natural,Timestamp,
ROW_NUMBER()OVER(PARTITION BY ProductionEventSK,BottleID_Natural,Timestamp
ORDER BY ProductionEventSK)  AS rn
FROM factproductionevent
)
DELETE FROM factproductionevent
WHERE ProductionEventSK IN ( SELECT ProductionEventSK FROM CTE WHERE rn > 1);

SELECT ProductionEventSK,BottleID_Natural,Timestamp,COUNT(*)
FROM factproductionevent
GROUP BY ProductionEventSK,BottleID_Natural,Timestamp
HAVING COUNT(*) > 1;


SELECT * FROM factproductionevent;

-- LIST OF USEFUL COLUMN WE NEED
/* ProductionEventSK,BottleID_Natural,operatorSK,LineID,Product,Shift,OperatorID_Natural,OperatorRole,
CapperMachineSK,CapperMachineID_Natural,JuiceBatchSK,BOTTLEBATCHSK,CapBatchSK,JuiceTemperatureC_In,
JuiceViscosity_cPs_Actual,TargetCapTorque_Nm,ActualCapTorque_Nm,CapHopperLevel_Percent,
AmbientHumidityPercent_Line,Defect_Type,LeakTestResult,UnderfillAmount_ml,CapperMaintenanceLast_Days_Snapshot,
Datekey,Timestamp,AmbientTemperatureC_Line
*/


-- SOLUTIONS TO NULLS VALUES IN EACH COLUMN NEEDED
-- TABLES WITH NULLS ARE TIMESTAMP,JuiceTemperatureC_In_null_pct,AmbientHumidityPercent_Line_null_pct,ActualCapTorque_Nm_null_pct
-- CapHopperLevel_Percent_null_pct

SELECT TIMESTAMP FROM factproductionevent
WHERE TIMESTAMP IS NULL;


SELECT JuiceTemperatureC_In FROM factproductionevent
WHERE JuiceTemperatureC_In IS NULL;

SELECT AVG(JuiceTemperatureC_In) FROM factproductionevent;

-- TRY FIRST 

ALTER TABLE factproductionevent
ADD COLUMN TRY_JuiceTemperatureC_In FLOAT;

UPDATE factproductionevent
SET try_JuiceTemperatureC_In = JuiceTemperatureC_In;

SELECT try_JuiceTemperatureC_In FROM factproductionevent;

UPDATE factproductionevent
SET try_JuiceTemperatureC_In = (
    SELECT AVG(temp.try_JuiceTemperatureC_In)
    FROM (SELECT try_JuiceTemperatureC_In FROM factproductionevent 
    WHERE try_JuiceTemperatureC_In IS NOT NULL) AS temp
)
WHERE try_JuiceTemperatureC_In IS NULL;

SELECT try_JuiceTemperatureC_In FROM factproductionevent
WHERE try_JuiceTemperatureC_In IS NULL;

ALTER TABLE factproductionevent
DROP COLUMN try_JuiceTemperatureC_In;

-- NOW CORRECT THE RIGHT TABLE JuiceTemperatureC_In

SELECT JuiceTemperatureC_In FROM factproductionevent
WHERE JuiceTemperatureC_In IS NULL;

UPDATE factproductionevent
SET JuiceTemperatureC_In = (
SELECT AVG(TEMP.JuiceTemperatureC_In) FROM 
(SELECT JuiceTemperatureC_In FROM factproductionevent
WHERE JuiceTemperatureC_In IS NOT NULL ) AS TEMP
)
WHERE JuiceTemperatureC_In IS NULL;


-- AmbientHumidityPercent_Line 

SELECT AmbientHumidityPercent_Line FROM factproductionevent;

SELECT AmbientHumidityPercent_Line FROM factproductionevent
WHERE AmbientHumidityPercent_Line IS NULL;

SELECT AVG(AmbientHumidityPercent_Line) FROM factproductionevent
WHERE AmbientHumidityPercent_Line IS NOT NULL;

UPDATE factproductionevent 
SET AmbientHumidityPercent_Line = 
(
SELECT  AVG(TEMP.AmbientHumidityPercent_Line) FROM 
(
SELECT AmbientHumidityPercent_Line FROM factproductionevent
WHERE AmbientHumidityPercent_Line IS NOT NULL) AS TEMP
)
WHERE AmbientHumidityPercent_Line IS NULL
; 

-- ActualCapTorque_Nm
SELECT ActualCapTorque_Nm FROM factproductionevent;

SELECT AVG(ActualCapTorque_Nm) FROM factproductionevent
WHERE ActualCapTorque_Nm IS NOT NULL;

-- NOTE THERE IS AN INCREASE IN THE ACTUAL CAP TORQUE

SELECT ActualCapTorque_Nm FROM factproductionevent
WHERE ActualCapTorque_Nm <= 2.1;

SELECT ActualCapTorque_Nm FROM factproductionevent
WHERE ActualCapTorque_Nm IS NULL;

SELECT TargetCapTorque_Nm,ActualCapTorque_Nm
FROM factproductionevent;

UPDATE factproductionevent 
SET ActualCapTorque_Nm = 
(
SELECT  AVG(TEMP.ActualCapTorque_Nm) FROM 
(
SELECT ActualCapTorque_Nm FROM factproductionevent
WHERE ActualCapTorque_Nm IS NOT NULL) AS TEMP
)
WHERE ActualCapTorque_Nm IS NULL
; 

--  CapHopperLevel_Percent

SELECT CapHopperLevel_Percent FROM factproductionevent
WHERE CapHopperLevel_Percent IS NULL;

SELECT AVG(TEMP.CapHopperLevel_Percent) FROM 
(
SELECT CapHopperLevel_Percent FROM factproductionevent
WHERE CapHopperLevel_Percent IS NOT NULL
) TEMP ;



-- --  BASELINE RANGE: Identify the range of production dates available 
-- FINDING THE PROBLEM 


SELECT * FROM dimcapbatch;
SELECT * FROM dimdate;
SELECT * FROM dimjuicebatch;
SELECT * FROM dimmachine;
SELECT * FROM dimnozzle;
SELECT * FROM dimoperator;
SELECT * FROM dimsupplier;
SELECT * FROM factproductionevent;


SELECT DISTINCT Defect_Type FROM factproductionevent;

SELECT BottleID_Natural,Defect_Type,
CASE WHEN Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END AS LeakyCap_count
FROM factproductionevent
ORDER BY LeakyCap_count DESC;


SELECT BottleID_Natural,Defect_Type,
CASE WHEN Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END AS LeakyCap_count
FROM factproductionevent
WHERE Defect_Type <> 'NONE' AND Defect_Type <> 'UNDERFILLED'
GROUP BY BottleID_Natural,Defect_Type
ORDER BY LeakyCap_count DESC;

-- DATE WHEN THE ISSUES STARTED   DAILY TREND
SELECT Datekey AS production_date,
        COUNT(BottleID_Natural) AS total_bottles,
        SUM(CASE WHEN Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
        SUM(CASE WHEN Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(BottleID_Natural) AS LeakyCap_percent
FROM factproductionevent
GROUP BY DATEKEY
ORDER BY DATEKEY;

--  CHECKING DEFECT WITH THE PRODUCTION LINE 
-- IT IS NOTICED THAT LEAKY CAP DEFECT AFFECTS ALL LINES
SELECT 
    f.LINEID,
    f.DateKey,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY f.LINEID, f.DateKey
ORDER BY f.DateKey, f.LINEID;

-- CHECKING SHIFT TIME

SELECT DISTINCT SHIFT FROM factproductionevent;

SELECT 
    f.SHIFT,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY f.SHIFT
ORDER BY LeakyCap_count ;

-- DimCapBatch.csv 


-- CHECKING DEFECT WITH THE CAPTYPE AND CAPMATERIAL
SELECT * FROM factproductionevent;
SELECT * FROM dimcapbatch;


-- FOR THE CAPMATERIAL I NOTICE THAT HDPE IS HAVING ISSUES
SELECT  
    f.DateKey,
    c.CapMaterial,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY f.DateKey, c.CapMaterial
ORDER BY f.DateKey, LeakyCap_count DESC;

-- FOR THE CAPTYPE I NOTICED THAT 28MM PCO 1881 HDPE IS HAVING ISSUES
SELECT  
    f.DateKey,
    c.CapType,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY f.DateKey, c.CapType
ORDER BY f.DateKey, LeakyCap_count DESC;

-- CHECKING FOR THE SUPPLIERSK
-- IT IS ALSO NOTICED THAT SUPPLIERSK 1 IS ALSO HAVING THE ISSUES
SELECT 
    c.SupplierSK,
    f.DateKey,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY c.SupplierSK, f.DateKey
ORDER BY f.DateKey, c.SupplierSK;

-- NOW LETES COMBINE THE SUPPLIERSK THE CAPTYPE AND THE CAP MATERIAL TOGETHER
-- NOW WE NOTICED THAT (CapMaterial,CapType,SupplierSK) ARE THE ONES WE ARE DEALING WITH
SELECT 
	c.CapMaterial,
    c.CapType,
    c.SupplierSK,
    f.DateKey,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY c.SupplierSK, f.DateKey, c.CapType,c.CapMaterial
ORDER BY LeakyCap_count DESC;

-- CHECKING ON SUPPLIERS

SELECT * FROM dimsupplier;
SELECT * FROM dimcapbatch;

SELECT s.SupplierSK,s.SupplierID_Natural,s.SupplierName FROM dimsupplier s 
JOIN dimcapbatch c ON s.SupplierSK = c.SupplierSK;

-- OVERALL CHECK 

SELECT 
	c.CapMaterial,
    c.CapType,
    c.SupplierSK,
    f.DateKey,
    s.SupplierID_Natural,
    s.SupplierName,
    s.country,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY c.SupplierSK, f.DateKey, c.CapType,c.CapMaterial,s.SupplierID_Natural,s.SupplierName,s.COUNTRY
ORDER BY LeakyCap_count DESC;


-- Hypothesis chain 
-- 1. CapType IS BAD
-- 2. CAUSE BY BAD CapMaterial
-- 3. BECCAUSE SUPPLIERSK 1 SUPLLY A BAD CAPTYPE
-- 4. SUPPLIERID_NATURAL CSUP05
-- 5. SUPPLIERNAME(Anambra Glass & PET)


-- TOTAL AMOUNT LOST 
SELECT 
	c.CapMaterial,
    c.CapType,
    f.DateKey,
    s.SupplierID_Natural,
    s.SupplierName,
    s.country,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent,
    SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) Amount_lost
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY  f.DateKey, c.CapType,c.CapMaterial,s.SupplierID_Natural,s.SupplierName,s.country
ORDER BY LeakyCap_count DESC;

-- CARRYING OUT MORE TESTING 

-- 1 WEEK BEFORE THE DEFECT DATE ---------------------------------
SELECT 
    f.DateKey,
    c.CapMaterial,
    c.CapType,
    s.SupplierName,
    SUM(CostPerCap_NGN) AS total_amount,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0 / COUNT(c.CapBatchID_Natural) AS LeakyCap_percent,
	SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) Amount_lost,
    SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) * 100.0 / SUM(c.CostPerCap_NGN) AS amount_lost_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s 
    ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-06-25' AND '2025-07-01'   -- 1 week BEFORE the defect days only
GROUP BY f.DateKey, c.CapType, c.CapMaterial, s.SupplierName
ORDER BY f.DateKey, LeakyCap_percent DESC;


CREATE VIEW weekbefore AS
SELECT 
    f.DateKey,
    c.CapMaterial,
    c.CapType,
    s.SupplierName,
    SUM(CostPerCap_NGN) AS total_amount,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0 / COUNT(c.CapBatchID_Natural) AS LeakyCap_percent,
	SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) Amount_lost,
    SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) * 100.0 / SUM(c.CostPerCap_NGN) AS amount_lost_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s 
    ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-06-25' AND '2025-07-01'   -- 1 week BEFORE the defect days only
GROUP BY f.DateKey, c.CapType, c.CapMaterial, s.SupplierName;
-- ORDER BY f.DateKey, LeakyCap_percent DESC;



-- 1 WEEK AFTER THE DEFECT ---------------------------------------------------------------------------
SELECT 
    f.DateKey,
    c.CapMaterial,
    c.CapType,
    s.SupplierName,
    SUM(CostPerCap_NGN) AS total_amount,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0 / COUNT(c.CapBatchID_Natural) AS LeakyCap_percent,
	SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) Amount_lost,
    SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) * 100.0 / SUM(c.CostPerCap_NGN) AS amount_lost_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s 
    ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-07-04' AND '2025-07-011'   -- 1 week AFTER the defect days only
GROUP BY f.DateKey, c.CapType, c.CapMaterial, s.SupplierName
ORDER BY f.DateKey, LeakyCap_percent DESC;



CREATE VIEW weekafter AS
SELECT 
    f.DateKey,
    c.CapMaterial,
    c.CapType,
    s.SupplierName,
    SUM(CostPerCap_NGN) AS total_amount,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0 / COUNT(c.CapBatchID_Natural) AS LeakyCap_percent,
	SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) Amount_lost,
    SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) * 100.0 / SUM(c.CostPerCap_NGN) AS amount_lost_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s 
    ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-07-04' AND '2025-07-011'   -- 1 week AFTER the defect days only
GROUP BY f.DateKey, c.CapType, c.CapMaterial, s.SupplierName;
-- ORDER BY f.DateKey, LeakyCap_percent DESC;

-- CHECKING ON ONLY THE SUPPLIER DETAILS
SELECT 
    c.SupplierSK,
    c.DateReceived,f.Datekey,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimmachine m ON c.CapBatchSK = m.MachineSK
JOIN dimnozzle n ON m.MachineSK = n.NozzleSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY c.SupplierSK, c.DateReceived,f.Datekey
ORDER BY total_CAPS DESC;

-- CHECKING ON HOW THE SUPPLIER HAS BEEN PEFORMING 1 WEEK EARLIER
-- (RECORD SHOWS THAT THE SUPPLIER 'Anambra Glass & PET' HAVENOT SUPPLIED US 1 WEEK EARIER)

SELECT 
    f.DateKey,
    c.CapMaterial,
    c.CapType,
    s.SupplierName,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0 / COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s 
    ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-06-25' AND '2025-07-01'   -- 1 week BEFORE the defect days only
AND c.CapType = '28mm PCO1881 HDPE' AND s.SupplierName = 'Anambra Glass & PET'
GROUP BY f.DateKey, c.CapType, c.CapMaterial, s.SupplierName
ORDER BY f.DateKey, LeakyCap_percent DESC;


-- CHECKING ON HOW THE SUPPLIER HAS BEEN PEFORMING 1 WEEK BEFORE
-- (RECORD SHOWS THAT THE SUPPLIER 'Anambra Glass & PET' HAVE BEEN  SUPPLING  US EVERYDAY FOR THE NEXT 1 WEEK OF THE DEFECT)

SELECT 
    f.DateKey,
    c.CapMaterial,
    c.CapType,
    s.SupplierName,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0 / COUNT(c.CapBatchID_Natural) AS LeakyCap_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s 
    ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-07-04' AND '2025-07-11'   -- 1 week AFTER the defect days
AND c.CapType = '28mm PCO1881 HDPE' AND s.SupplierName = 'Anambra Glass & PET'
GROUP BY f.DateKey, c.CapType, c.CapMaterial, s.SupplierName
ORDER BY f.DateKey, LeakyCap_percent DESC;


-- COMBINING ALL NEED TABLES AND QUERYS TOGETHER TO IMPORT TO POWERBI

SELECT 
	c.CapMaterial,
    c.CapType,
    f.DateKey,
    s.SupplierID_Natural,
    s.SupplierName,
    s.country,
    SUM(CostPerCap_NGN) AS total_amount,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent,
    SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) Amount_lost,
    SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) * 100.0 / SUM(c.CostPerCap_NGN) AS amount_lost_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY  f.DateKey, c.CapType,c.CapMaterial,s.SupplierID_Natural,s.SupplierName,s.country
ORDER BY LeakyCap_count DESC;


CREATE VIEW all_metrics_capped AS
SELECT 
	c.CapMaterial,
    c.CapType,
    f.DateKey,
    s.SupplierID_Natural,
    s.SupplierName,
    s.country,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CostPerCap_NGN) AS total_amount,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent,
    SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) Amount_lost,
    SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) * 100.0 / SUM(c.CostPerCap_NGN) AS amount_lost_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-07-02' AND '2025-07-03'
GROUP BY  f.DateKey, c.CapType,c.CapMaterial,s.SupplierID_Natural,s.SupplierName,s.country;
-- ORDER BY LeakyCap_count DESC;

-- CREATE VIEW beforeafter AS
SELECT 
	c.CapMaterial,
    c.CapType,
    f.DateKey,
    s.SupplierID_Natural,
    s.SupplierName,
    s.country,
    COUNT(c.CapBatchID_Natural) AS total_CAPS,
    SUM(CostPerCap_NGN) AS total_amount,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) AS LeakyCap_count,
    SUM(CASE WHEN f.Defect_Type IN ('LeakyCap', 'both') THEN 1 ELSE 0 END) * 100.0/COUNT(c.CapBatchID_Natural) AS LeakyCap_percent,
    SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) Amount_lost,
    SUM(CASE WHEN Defect_type IN ('LeakyCap', 'both') THEN c.CostPerCap_NGN ELSE 0 END) * 100.0 / SUM(c.CostPerCap_NGN) AS amount_lost_percent
FROM factproductionevent f
JOIN dimcapbatch c 
    ON f.CapBatchSK = c.CapBatchSK
JOIN dimsupplier s ON c.SupplierSK = s.SupplierSK
WHERE f.DateKey BETWEEN '2025-06-25' AND '2025-07-11'
GROUP BY  f.DateKey, c.CapType,c.CapMaterial,s.SupplierID_Natural,s.SupplierName,s.country
order by Datekey;

SELECT * FROM all_metrics_capped;
select * from weekafter;
select * from weekbefore;
select * from beforeafter;

select distinct capmaterial from all_metrics_capped;
select distinct capmaterial from dimcapbatch;