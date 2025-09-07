# Nature's Best Drink leakyCap RCA

## 📚 Table of Contents
- [CONTEXT AND PROBLEM](#context-and-problem)     
- [BUSINESS IMPACT](#business-impact)   
- [ER DIAGRAM](#er-diagram)  
- [DATA CLEANING](#data-cleaning)
- [ANALYSIS](#analysis)  
- [QUERIES AND LOGIC USED (VIEWS)](#queries-and-logic-used-views)
- [VISUALIZATIONS](#visualizations)
- [RECOMMENDATIONS](#recommendations)
- [WHY WE ARE CONFIDENT THE FIX WILL WORK](#why-we-are-confident-the-fix-will-work)

## CONTEXT AND PROBLEM
In the same operational week at the Onitsha plant, Nature Best Juice Co. experienced an unusual spike in Leaky Cap defects across multiple lines, concentrated on July 2–3, 2025. The surge exceeded normal levels, disrupted production, and signaled potential issues in the capping process, materials, or controls that need urgent investigation.

### Problem Statement
During the same operational week at the Onitsha plant, Nature Best Juice Co. experienced an unusual and sharp spike in Leaky Cap defects across multiple production lines. The issue was concentrated on Wednesday, July 2, 2025, and Thursday, July 3, 2025, significantly exceeding defect levels recorded on other days within the week. This sudden rise in defective caps disrupted normal production performance and highlighted a potential underlying issue within the capping process, materials, or operational controls that requires immediate investigation and resolution.

### Who are the stakeholders
 - **Procurement Manager** → suspects a bad batch from a supplier 
 - **Quality Control Lead** → needs clarity on whether this was a system-wide issue 
 - **Line Managers** → want to isolate the problem quickly to resume normal production

## BUSINESS IMPACT
From the 2 days of leaky cap issues (July 2–3):
 - 3,355 leaky caps recorded, with thousands more in the following week
 - Daily losses jumped to 34.3% compared to just 2.1% the previous week
 - Financial losses totaled about ₦45,000 in 2 days, versus only ₦6,000 the week before

## Data Exploration and Schema Design
We worked on a structured production dataset built around a star schema with a central fact table called "**FactProductionEvent**"
- **DimDate** -- This is the calendar table
- **DimSupplier** -- This table contains information about the companies that supply us with empty bottles
- **DimCapBatch** -- This table provides information about each delivery (batch) of bottle caps we 
receive. 

### ER DIAGRAM

The ER diagram is use to visualize table relationships and track foreign keys used during analysis.

<img width="502" height="404" alt="ER diagram" src="https://github.com/user-attachments/assets/94f76626-16ae-4a94-88d7-0950338b4ef4" />

## DATA CLEANING

  **PHASE 1**

**STANDARDIZING NUMERICS COLUMNS**
  
The cleaning are done on the following column where we noticed unusual Numerics values,symbols and text.
Note that this cleaning was carried out before any analysis (RCA)
 - **Timestamp** -- are critical for trend analysis, cleaning them first ensured that sorting, filtering and comparisons worked properly. We fixed malformed and inconsistent formats, recast from text to datetime.
 - **JuiceTemperatureC_In** -- this column are neccessary for the determinations of the various temperatgure of the juice as at when produced. it contains some unusual rows like 'WAY TOO HOT','SENSOR_BROKEN','COLD!','HOT!'
 - **ActualCapTorque_Nm** -- The actual "tightness" measured for the cap on this bottle, in Newton
meters.
 - **AmbientTemperatureC_Line** -- The air temperature around the production line when this 
bottle was processed, in degrees Celsius.  

  **PHASE 2**

   **STANDARDIZING TEXT COLUMNS**

- **Defect Result(String):** this column tells us the kind of problem (if any) was found with this bottle: "None" (no defect), 
"Underfilled" (not enough juice), "Leaky_Cap" (the cap leaks), or "Both" (both underfilled and leaky). so all other similar rows are group and categorize into this category
- **LeakTestResult(String):** The outcome of the test to see if the bottle leaks: "Pass" (it doesn't leak) or 
"Fail" (it leaks).

**PHASE 3**

**REMOVING DUPLICATES**
  
We tested key columns to identify duplicate values in the dataset. After analysis, we removed all duplicate rows. In total, over 32,000 duplicate records were deleted, ensuring the dataset is accurate, consistent, and ready for reliable analysis.
  **Steps:**
1. Detect duplicates with COUNT(*)
2. Create an index to speed up the update
3. Use a CTE with ROW_NUMBER() to retain one copy of each duplicate set
4. Delete all extra duplicate rows

 - **Code Used for Testing and Deleting all Duplicate** 

```sql
SELECT ProductionEventSK,BottleID_Natural,Timestamp, COUNT(*)
FROM FactProductionEvent
GROUP BY ProductionEventSK,BottleID_Natural,`Timestamp`
HAVING COUNT(*) > 1;

SELECT ProductionEventSK,BottleID_Natural,Timestamp 
FROM factproductionevent
WHERE ProductionEventSK IN (275543,256831,160069)
ORDER BY ProductionEventSK;

-- NOW CREATE INDEX TO QUICKEN THE UPDATE 
CREATE INDEX IDX_DUPLICATE 
ON factproductionevent (ProductionEventSK(100),BottleID_Natural(100),`Timestamp`);

SHOW INDEX FROM factproductionevent;

-- DELETING ALL DUPLICATES
WITH CTE AS (
    SELECT ProductionEventSK,BottleID_Natural,Timestamp,
           ROW_NUMBER() OVER(PARTITION BY ProductionEventSK,BottleID_Natural,Timestamp
                             ORDER BY ProductionEventSK) AS rn
    FROM factproductionevent
)
DELETE FROM factproductionevent
WHERE ProductionEventSK IN (SELECT ProductionEventSK FROM CTE WHERE rn > 1);

-- Check if duplicates still exist
SELECT ProductionEventSK,BottleID_Natural,Timestamp,COUNT(*)
FROM factproductionevent
GROUP BY ProductionEventSK,BottleID_Natural,Timestamp
HAVING COUNT(*) > 1;
```

   **PHASE 4**
 
**Handling NULL Values**
During the data cleaning process, several key columns contained missing values (NULL) such as:
 - JuiceTemperatureC_In
 - AmbientHumidityPercent_Line
 - ActualCapTorque_Nm
 - CapHopperLevel_Percent

  ### Solution Applied

   **1. Detection of NULLs**
 
  Queried each column to identify how many rows contained missing values.

   **2. Calculation of Replacement Values**
 
  Computed the column average (AVG()) using only non-NULL records.

   **3. Imputation**
 
  Replaced all NULL values with their respective column averages, ensuring consistency in analysis.

   **4. Validation**
 
  Rechecked the columns to confirm no remaining NULL values.

 ### Why This Approach?

- Using averages avoids dropping valuable records.

- Maintains dataset size for downstream analysis.

- Provides a balanced, non-biased replacement that reflects typical operating values.

## Hypothesis Exploration

 **Before we confirmed the root cause, we explore the following hypthesis:**

 - Date when the issues started: although the date has been given to us but we did that to confirm it and also to know the analysis days before now
 - Checking defect with the production line
 - Checking defect with shift time
 - Checking defect with the Captype and Capmaterial

## ANALYSIS

### Metrics We Calculated

 - Total Caps Produced: Number of caps supplied during production.
 - Defective Caps (LeakyCap_count): Number of defective caps (only LeakyCap or both defects).
 - Defect Rate (%) (LeakyCap_percent): Percentage of defective caps relative to all caps.
 - Total Amount Spent on Caps: Amount spend on all caps supplied for the period.
 - Amount Lost from Defects: Amount lost on all caps supplied for the period due to defective caps.
 - % of Amount Lost: Percentage of amount lost to defective caps.

## How We Tested Each Hypothesis

 **1. Hypothesis 1:** Cap Type is faulty
  - **Test:** Grouped by CapType, compared defect counts and defect rate.
  - **Finding:** 28mm PCO 1881 HDPE showed highest defect rates.

**2. Hypothesis 2:** Bad Cap Material causes the issue
  - **Test:** Grouped by CapMaterial (e.g., HDPE vs others).
  - **Finding:** HDPE had unusually high defect counts.

**3. Hypothesis 3:** SupplierSK 1 supplied the defective caps
  - **Test:** Grouped by SupplierSK and checked LeakyCap_count & % across suppliers.
  - **Finding:** SupplierSK = 1 had the largest share of defects → supported.

**4. Hypothesis 4:** The faulty supplier is CSUP05 (Anambra Glass & PET)
  - **Test:** Joined dimSupplier to trace SupplierSK → SupplierName.
  - **Finding:** SupplierID_Natural = CSUP05 ("Anambra Glass & PET).

**5. Hypothesis 5:** Supplier performance varies before vs after defect dates
- **Test:**
   - 1 week before (June 25–July 1) - no supply issues from Anambra Glass & PET.
   - During defect days (July 2–3) - major spike in defects.
   - 1 week after (July 4–11) - supplier kept supplying, defects continued.
- **Finding:** The problem started when they supplied HDPE caps for July 2–3 and persisted afterward.

## QUERIES AND LOGIC USED (VIEWS)
We created 4 unified view to simpplify analysis and reuse in PowerBi

**Logic**

**View 1:** Defect Days (2–3 July 2025)

This view captures all metrics during the defect days.

```sql
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
```

**View 2:** One Week Before Defect

Analyzes trends and defect levels one week before the defect event (25 June – 1 July 2025).

```sql
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
GROUP BY f.DateKey, c.CapType, c.CapMaterial, s.SupplierName
ORDER BY f.DateKey, LeakyCap_percent DESC;
```
**View 3:** One Week After Defect

Tracks post-defect behavior and costs (4 – 11 July 2025).

```sql
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
```

**View 4:** Combined Metrics (Before, During, After)

A view covering the entire period from 25 June to 11 July 2025 for side-by-side comparison.

```sql
CREATE VIEW allmetrics AS
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
GROUP BY  f.DateKey, c.CapType,c.CapMaterial,s.SupplierID_Natural,s.SupplierName,s.country;
```

## Root Cause Summary
The sudden rise in LeakyCap defects on July 2–3, 2025 was linked to a faulty supplier batch, not internal operations. This caused higher cap waste  but was confirmed as a supplier quality issue, not an ongoing risk.

## VISUALIZATIONS

|Procurement Manager|
|------|

 <img width="620" height="346" alt="procument manager" src="https://github.com/user-attachments/assets/bc0818c7-5d32-4d3e-a866-8b642d009d77" /> 
 
 |Quality Control Lead|
 |------|
 
 <img width="616" height="346" alt="Quality Control Lead" src="https://github.com/user-attachments/assets/abada81b-711e-4f24-b7c9-5d46d8e6191f" />


## RECOMMENDATIONS

  - Pause or limit supply of Anambra Glass & PET HDPE 28mm PCO1881 caps   until quality issues are fully resolved to prevent further defective products and financial losses.

 - Rely on established suppliers such as Premium Closures NG, ADAC Containers Ltd., and Eco Cap Supplies, who have demonstrated stable performance, to maintain production reliability and minimize risk.

## WHY WE ARE CONFIDENT THE FIX WILL WORK

 **1. Supplier-Linked Defect:** Analysis confirmed that the spike in leaky caps on July 2–3 came entirely from Anambra Glass & PET’s HDPE 28mm PCO1881 batch, with other suppliers unaffected.

 **2. Root Cause Verified:** Previous data shows no prior issues with this cap type from other suppliers, ruling out internal production or handling as the cause.

 **3. Proven Corrective Action:** Stopping or limiting supply from the faulty batch and checking the supplier’s process directly addresses the problem, making sure that future supply caps are good quality.

