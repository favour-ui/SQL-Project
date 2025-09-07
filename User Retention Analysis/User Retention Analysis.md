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

Ensured all timestamp fields (login_time, timestamp, sign_up_date) were stored in DATETIME or DATE format.

Converted inconsistent formats (e.g., text-based timestamps like "2025/02/20 12:00" - standard YYYY-MM-DD HH:MM:SS).

Created derived fields such as week_num using TIMESTAMPDIFF(WEEK, launch_date, login_time) for cohort retention analysis.

**Business Impact:** Ensures consistency in time-based analysis, making retention curves and weekly engagement trends accurate and comparable.




















