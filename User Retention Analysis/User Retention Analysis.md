# User Retention Analysis

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

### Handling NULL Values

 - Replaced missing values in activity_type with "Null".

 - Dropped rows with NULL user_id since these can’t be tied to real users.

 - Ensured all records included valid sign_up_date and timestamp values.

 - For reporting, excluded invalid rows rather than imputing, to keep adoption/retention rates conservative.

 - Business Impact: Filters out incomplete or unreliable data, ensuring results reflect only valid, trackable users.














