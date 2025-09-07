# User Retention Analysis

## 📚 Table of Contents
- [CONTEXT](#context)
- [PROBLEM](#PROBLEM)
    - [Who are the stakeholders](#Who-are-the-stakeholders)       
- [BUSINESS IMPACT](#business-impact)
     - [Data Exploration and Schema Design](#Data-Exploration-and-Schema-Design) 
- [ER DIAGRAM](#er-diagram)  
- [DATA CLEANING](#data-cleaning)
     - [PHASE 1](#PHASE-1)
     - [PHASE 2](#PHASE-2)
     - [PHASE 3](#PHASE-3)
     - [PHASE 4](#PHASE-4)
     - [PHASE 5](#PHASE-5)
- [ANALYSIS](#analysis)
     - [Metrics We Calculated](#Metrics-We-Calculated) 
- [QUERIES AND LOGIC USED (VIEWS)](#queries-and-logic-used-views)
- [VISUALIZATIONS](#visualizations)
- [RECOMMENDATIONS](#recommendations)
- [WHY WE ARE CONFIDENT THE FIX WILL WORK](#why-we-are-confident-the-fix-will-work)


## CONTEXT
On February 20, 2025, Colume introduced three new features — Task Reminders, Voice Assistant, and Custom Themes. The product team wants to understand how these features influence user behavior, particularly their impact on retention and long-term engagement.

## PROBLEM
We need to evaluate whether users who adopted these features within the first 7 days of launch show higher weekly retention compared to those who did not. This analysis will reveal if early feature adoption directly improves stickiness and sustained engagement, guiding future feature rollouts and engagement strategies.

### Who are the stakeholders
Stakeholder: Product Team

## BUSINESS IMPACT

The analysis reveals that feature adopters retain nearly twice as much as non-adopters (78% vs. 40% by Week 9). This shows that the new features significantly increase user stickiness and long-term engagement.

By driving more users toward adopting features like Task Reminders or Voice Assistant, Colume can:

 - **Reduce churn rates:** directly increasing customer lifetime value (CLV).

 - **Boost active user base:** ensuring stronger daily/weekly engagement metrics.

 - **Improve ROI of feature development:** showing clear evidence that product innovations lead to measurable retention gains.

### Data Exploration and Schema Design


We worked on a structured detailed  dataset built around a star schema with a central fact table called "**activity_log**"

 - **features.csv (Features Table)**
 - **users.csv (Users Table)**
 - **sessions.csv (Sessions Table)**

## ER DIAGRAM

<img width="795" height="704" alt="COLUME ER DIAGRAM" 
 src="https://github.com/user-attachments/assets/fdad806d-0c2e-4134-a4df-e16a2ecbe031" />

## DATA CLEANING

### PHASE 1

**Standardizing Numeric Columns**

 - Ensured all numeric fields (e.g., user_id, session_id, activity_id) were in the correct data type (INT or BIGINT) to prevent mismatches during joins.

 - Converted any string-based numeric values into proper numeric formats.

 - Validated that measures like retained_users, cohort_size, and counts were computed as integers, avoiding issues with text-based aggregation.

**Business Impact:** Guarantees consistency when aggregating or calculating metrics (e.g., retention rates, adoption counts).

### PHASE 2

**STANDARDIZING TEXT COLUMNS**

 - Converted all activity types to a consistent mapped format (task_reminder - Task Reminders, voice_assistant - Voice Assistant, custom_theme - Custom Themes).

   **LOGIC AND QUERY USED**

```sql
   
ALTER TABLE activity_log ADD COLUMN mapped_activity_type VARCHAR(100);
 
UPDATE activity_log
SET mapped_activity_type = CASE
    WHEN activity_type = 'task_reminder' THEN 'Task Reminders'
    WHEN activity_type = 'voice_assistant' THEN 'Voice Assistant'
    WHEN activity_type = 'custom_theme'   THEN 'Custom Themes'
    ELSE activity_type
END;
```

 - Applied consistent casing (Title Case) across features (Feature Name) to match activity log values.

 - Removed extra spaces and corrected inconsistent naming.

**Business Impact:** Ensures features and activities can be reliably joined across tables (e.g., activity_log - features). Without this, adoption metrics would undercount due to mismatches.

### PHASE 3

**Standardizing Timestamp Columns**

 - Ensured all timestamp fields (login_time, timestamp, sign_up_date) were stored in DATETIME or DATE format.

 - Converted inconsistent formats (e.g., text-based timestamps like "2025/02/20 12:00" - standard YYYY-MM-DD HH:MM:SS).

 - Created derived fields such as week_num using TIMESTAMPDIFF(WEEK, launch_date, login_time) for cohort retention analysis.

**Business Impact:** Ensures consistency in time-based analysis, making retention curves and weekly engagement trends accurate and comparable.

### PHASE 4

**REMOVING DUPLICATES**

 - Checked for duplicate entries in key logs:

   **Users Table:** Ensured unique user_id.

**LOGIC AND QUERY USED**
  
  ```sql
SELECT * FROM USERS;
 
 SELECT `Full name`,Email,sign_up_date,COUNT(*)
 FROM USERS
 GROUP BY `Full name`,Email,sign_up_date
 HAVING COUNT(*) > 1;

WITH CTE AS (SELECT user_id,`Full name`,Email,sign_up_date,
ROW_NUMBER() OVER (PARTITION BY `Full name`, Email, sign_up_date
ORDER BY user_id
) AS rn
FROM users
)
SELECT * FROM CTE WHERE rn > 1;


WITH CTE AS (
SELECT user_id,`Full name`,Email,sign_up_date,
ROW_NUMBER()OVER(PARTITION BY `Full name`,Email,sign_up_date
ORDER BY user_id)  AS rn
FROM users
)
DELETE FROM users
WHERE user_id IN ( SELECT user_id FROM CTE WHERE rn > 1);

```

   **Sessions Table:** Validated no duplicate (session_id, user_id, login_time) rows.

**LOGIC AND QUERY USED**

```sql
SELECT user_id, login_time, device_type, COUNT(*) AS duplicate_count
FROM sessions
GROUP BY user_id, login_time, device_type
HAVING COUNT(*) > 1;

SELECT user_id,login_time,device_type
FROM sessions
WHERE user_id = 'nujjq9' AND device_type = 'Web\r' AND login_time = '2025-03-13 11:36:42';


SELECT * FROM sessions;

WITH CTE AS (SELECT session_id,
ROW_NUMBER() OVER (
PARTITION BY user_id, login_time, device_type
ORDER BY session_id
) AS rn
FROM sessions
)
DELETE FROM sessions
WHERE session_id IN (
    SELECT session_id 
    FROM (SELECT session_id FROM CTE WHERE rn > 1) AS x
);
 SHOW PROCESSLIST;
  CREATE INDEX IDX_DUPLICATE ON sessions (session_id(20),user_id(20),login_time,device_type(20));
 KILL 33;
 SELECT * FROM sessions;
 
```

   **Activity Log:** Removed repeated actions logged multiple times by error.

 - Used COUNT(DISTINCT ...) in queries to prevent duplicates from inflating adoption/retention numbers.

**Business Impact:** Prevents overestimation of active users, adopters, or retention, giving stakeholders a true picture of user behavior.

### PHASE 5

### Handling NULL Values

 - Replaced missing values in activity_type with "Null".

 - Dropped rows with NULL user_id since these can’t be tied to real users.

 - Ensured all records included valid sign_up_date and timestamp values.

 - For reporting, excluded invalid rows rather than imputing, to keep adoption/retention rates conservative.

 - Business Impact: Filters out incomplete or unreliable data, ensuring results reflect only valid, trackable users.

## ANALYSIS

### Metrics We Calculated

To evaluate the impact of new feature adoption on retention, we derived the following key metrics:

**Total Users (Cohort Size):**
Number of distinct users who signed up before or on the feature launch date (2025-02-20).

**Adopters (First 7 Days):**
Users who engaged with at least one of the new features (Task Reminders, Voice Assistant, Custom Themes) between launch day and Day 7.

**Non-Adopters (First 7 Days):**
Users who did not engage with any of the new features within the first 7 days post-launch.

**Retention Rate (Weekly):**
% of users who remained active in subsequent weeks after launch, calculated separately for adopters and non-adopters.

**Adopters vs Non-Adopters (%) Comparison:**
Direct comparison of retention rates to quantify the uplift in retention driven by feature adoption.

**Daily Adoption Trend:**
Number of adopters by day of the week within the first 7 days post-launch.

### QUERIES AND LOGIC USED (VIEWS)

We created 6 unified view to simpplify analysis and reuse in PowerBi


**1. Total Users (Cohort Size):** 

```sql
SELECT COUNT(DISTINCT user_id) AS total_users
FROM users
WHERE sign_up_date <= '2025-02-20';
```

**2. Adopters (First 7 Days):**

```sql
SELECT COUNT(DISTINCT a.user_id) AS users_used_new_feature
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27';
```

**3. Non-Adopters (First 7 Days):**

```sql
WITH ADOPTERS AS (
 SELECT DISTINCT a.user_id
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27'
),
ALL_USERS AS (
SELECT DISTINCT user_id
FROM activity_log
WHERE timestamp BETWEEN '2025-02-20' AND '2025-02-27'
),
NON_ADOPTERS AS (
SELECT u.user_id
FROM ALL_USERS u
LEFT JOIN ADOPTERS a ON u.user_id = a.user_id
 WHERE a.user_id IS NULL
)  

SELECT  (SELECT COUNT(*) FROM ADOPTERS) AS adopters,
    (SELECT COUNT(*) FROM NON_ADOPTERS) AS non_adopters,
    (SELECT COUNT(*) FROM ALL_USERS) AS total_users;
```

**4. Retention Rate (Weekly):**

```sql
WITH adopters AS (
 SELECT DISTINCT a.user_id
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27'
),
-- I USED sign_up_date BECAUSE WE WANT TO KNOW THOSE WHO HAVE ALREADY SIGN UP BUT DIDNOT USE THE NEW FEATURE BECAUSE T HAS NOT BEEN LUNCH

-- Non-adopters - users who signed up before launch but never used the new feature in the adoption window.

non_adopters AS (
   SELECT DISTINCT u.user_id
   FROM USERS u
   WHERE u.user_id NOT IN (SELECT user_id FROM adopters)
   AND u.sign_up_date <= '2025-02-20'
),

-- THIS TELLS US HOW PEAOPLE USED OR RETAIN ON THE WEBSITE AFTER THE NEW FEATURES ARE LAUNCH WEEK BY WEEK 

weekly_activity AS (
 SELECT user_id,
  timestampdiff(WEEK, DATE('2025-02-20'), LOGIN_TIME) AS week_num
 FROM sessions
 WHERE LOGIN_TIME >= '2025-02-20'
),

-- This is the number of unique users who adopted (used at least one of) the new features within the first 7 days after launch.

adopter_retention AS (
 SELECT w.week_num ,
 COUNT(DISTINCT w.user_id) AS adopters_retained_users,
 (SELECT COUNT(*) FROM adopters)  AS adopters_cohort_size
 FROM weekly_activity w
 JOIN adopters a ON w.user_id = a.user_id
 GROUP BY w.week_num
),

-- This is the number of users who had already signed up before launch but did not adopt any of the new features 
-- during the first 7 days.

non_adopter_retention AS (
SELECT w.week_num ,
 COUNT(DISTINCT w.user_id) AS non_adopters_retained_users,
 (SELECT COUNT(*) FROM non_adopters)  AS non_adopters_cohort_size
 FROM weekly_activity w
 JOIN non_adopters n ON w.user_id = n.user_id
 GROUP BY w.week_num
)
SELECT 
    IFNULL(a.week_num, n.week_num) AS week_num,
    a.adopters_retained_users,
    a.adopters_cohort_size,
     ROUND((a.adopters_retained_users / a.adopters_cohort_size) * 100, 2) AS adopters_retention_rate,
    n.non_adopters_retained_users,
    n.non_adopters_cohort_size,
    ROUND((n.non_adopters_retained_users / n.non_adopters_cohort_size) * 100, 2) AS non_adopters_retention_rate
FROM adopter_retention a
LEFT JOIN non_adopter_retention n
  ON a.week_num = n.week_num
  
  UNION 

SELECT 
    IFNULL(a.week_num, n.week_num) AS week_num,
    a.adopters_retained_users,
    a.adopters_cohort_size,
    ROUND((a.adopters_retained_users / a.adopters_cohort_size) * 100, 2) AS adopters_retention_rate,
    n.non_adopters_retained_users,
    n.non_adopters_cohort_size,
    ROUND((n.non_adopters_retained_users / n.non_adopters_cohort_size) * 100, 2) AS non_adopters_retention_rate
FROM adopter_retention a
RIGHT JOIN non_adopter_retention n
  ON a.week_num = n.week_num
  
ORDER BY week_num;
```

**5. Adopters vs Non-Adopters (%) Comparison:**

```sql
 SELECT * FROM activity_log;
 
 WITH adopters AS (
 SELECT DISTINCT a.user_id
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27'
),
-- I USED sign_up_date BECAUSE WE WANT TO KNOW THOSE WHO HAVE ALREADY SIGN UP BUT DIDNOT USE THE NEW FEATURE BECAUSE T HAS NOT BEEN LUNCH

-- Non-adopters - users who signed up before launch but never used the new feature in the adoption window.

non_adopters AS (
   SELECT DISTINCT u.user_id
   FROM USERS u
   WHERE u.user_id NOT IN (SELECT user_id FROM adopters)
   AND u.sign_up_date <= '2025-02-20'
),

-- THIS TELLS US HOW PEAOPLE USED OR RETAIN ON THE WEBSITE AFTER THE NEW FEATURES ARE LAUNCH WEEK BY WEEK 

weekly_activity AS (
 SELECT user_id,
  timestampdiff(WEEK, DATE('2025-02-20'), LOGIN_TIME) AS week_num
 FROM sessions
 WHERE LOGIN_TIME >= '2025-02-20'
),

-- This is the number of unique users who adopted (used at least one of) the new features within the first 7 days after launch.

adopter_retention AS (
 SELECT w.week_num ,
 COUNT(DISTINCT w.user_id) AS adopters_retained_users,
 (SELECT COUNT(*) FROM adopters)  AS adopters_cohort_size
 FROM weekly_activity w
 JOIN adopters a ON w.user_id = a.user_id
 GROUP BY w.week_num
),

-- This is the number of users who had already signed up before launch but did not adopt any of the new features 
-- during the first 7 days.

non_adopter_retention AS (
SELECT w.week_num ,
 COUNT(DISTINCT w.user_id) AS non_adopters_retained_users,
 (SELECT COUNT(*) FROM non_adopters)  AS non_adopters_cohort_size
 FROM weekly_activity w
 JOIN non_adopters n ON w.user_id = n.user_id
 GROUP BY w.week_num
),
COMBINED AS (
SELECT 
    IFNULL(a.week_num, n.week_num) AS week_num,
    a.adopters_retained_users,
    a.adopters_cohort_size,
     ROUND((a.adopters_retained_users / a.adopters_cohort_size) * 100, 2) AS adopters_retention_rate,
    n.non_adopters_retained_users,
    n.non_adopters_cohort_size,
    ROUND((n.non_adopters_retained_users / n.non_adopters_cohort_size) * 100, 2) AS non_adopters_retention_rate
FROM adopter_retention a
LEFT JOIN non_adopter_retention n
  ON a.week_num = n.week_num
  
  UNION 

SELECT 
    IFNULL(a.week_num, n.week_num) AS week_num,
    a.adopters_retained_users,
    a.adopters_cohort_size,
    ROUND((a.adopters_retained_users / a.adopters_cohort_size) * 100, 2) AS adopters_retention_rate,
    n.non_adopters_retained_users,
    n.non_adopters_cohort_size,
    ROUND((n.non_adopters_retained_users / n.non_adopters_cohort_size) * 100, 2) AS non_adopters_retention_rate
FROM adopter_retention a
RIGHT JOIN non_adopter_retention n
  ON a.week_num = n.week_num
  )
SELECT week_num,
adopters_retention_rate,
non_adopters_retention_rate,
(adopters_retention_rate - non_adopters_retention_rate) AS feature_effect_percent
FROM COMBINED
ORDER BY week_num;
```

**6. Daily Adoption Trend:**

```sql
  SELECT DAYNAME(a.timestamp) AS day_name,
  COUNT(DISTINCT a.user_id) AS users_used_new_feature
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27'
  GROUP BY DAYNAME(a.timestamp)
ORDER BY MIN(DATE(a.timestamp));
```

## VISUALIZATIONS

|Stakeholder|
|-----------|

   |Overview|
   |--------|
           
<img width="605" height="336" alt="User retention overview" src="https://github.com/user-attachments/assets/c062a76a-4527-466c-8b92-cc84423e7d60" />

  |Insight and Recommendation|
   |--------|

<img width="604" height="337" alt="insight and recommendation" src="https://github.com/user-attachments/assets/3552956a-e7a3-4efe-a6f7-7b0924f22556" />


## RECOMMENDATIONS

 - **Promote Feature Adoption:**

    - Add onboarding nudges (pop-ups, tooltips, short tutorials) to encourage non-adopters to try key features such as Task Reminders or Voice Assistant.
    - Offer small incentives (badges, discounts, productivity tips) for first-time feature usage to lower adoption barriers.

 - **Target Non-Adopters With Campaigns**

   - Launch email and push notification campaigns that highlight the benefits of the new features.
   - Share case studies or user success stories (e.g., “Users who set Task Reminders are 2x more productive”) to create social proof and motivation.

The data shows that new features significantly increase retention. Adopters retain at almost double the rate of non-adopters (78% vs 40%). To maximize long-term engagement, the top priority should be converting non-adopters into adopters through guided onboarding, proactive nudges, and targeted campaigns.

## WHY WE ARE CONFIDENT THE FIX WILL WORK

**1. Proven Retention Uplift**
Adopters consistently retain at nearly double the rate of non-adopters (78% vs 40%), showing a clear and sustained impact of feature adoption.

**2. Robust and Fair Analysis**
Cohorts were carefully defined (users signed up before launch), data was cleaned, and retention measured week by week—ensuring the comparison is accurate and unbiased.

**3. Actionable Opportunity**
The gap shows us the solution: get more users to try the new features. Since adopters stay longer, encouraging non-adopters to use the features will directly increase retention.
