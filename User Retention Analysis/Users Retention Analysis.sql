SELECT * FROM users;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sessions.csv'
INTO TABLE sessions
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- CHECKING ON TABLE ACTIVITY LOG

SELECT * FROM activity_log;
SELECT COUNT(*) AS Total,
COUNT(activity_id) AS activity_id_null,
count(session_id) as session_id_NULL,
COUNT(user_id) AS user_id_null,
COUNT(activity_type)  AS activity_type_null,
COUNT(timestamp) AS timestamp_null
FROM activity_log;

SELECT COUNT(*) AS TOTAL,
(COUNT(*) - COUNT(activity_id)) * 100  / COUNT(*) AS activity_id_null_pct,
(COUNT(*) - COUNT(session_id)) * 100  / COUNT(*) AS session_id_null_pct,
(COUNT(*) - COUNT(user_id)) * 100  / COUNT(*) AS user_id_null_pct,
(COUNT(*) - COUNT(activity_type)) * 100  / COUNT(*) AS activity_type_null_pct,
(COUNT(*) - COUNT(timestamp)) * 100  / COUNT(*) AS timestamp_null_pct
FROM activity_log;


SELECT activity_id 
FROM activity_log
WHERE activity_id = '';

SELECT session_id 
FROM activity_log
WHERE session_id = '';

SELECT timestamp 
FROM activity_log
WHERE timestamp = '';

SELECT DISTINCT activity_type 
FROM activity_log;
SELECT COUNT(*) FROM activity_log;
SELECT DISTINCT USER_ID FROM activity_log;

-- CHECKING ON BILLING TABLE 

SELECT * FROM billing;

SELECT COUNT(plan_type)
FROM billing
WHERE plan_type = '';

SELECT COUNT(currency)
FROM billing
WHERE currency = '';

SELECT COUNT(payment_method)
FROM billing
WHERE payment_method = '';

UPDATE billing
SET plan_type = NULLIF(plan_type,''),
currency = NULLIF(currency,'');

SELECT COUNT(*) AS TOTAL,
(COUNT(*) - COUNT(billing_id)) * 100  / COUNT(*) AS billing_id_null_pct,
(COUNT(*) - COUNT(user_id)) * 100  / COUNT(*) AS user_id_null_pct,
(COUNT(*) - COUNT(billing_date)) * 100  / COUNT(*) AS billing_date_null_pct,
(COUNT(*) - COUNT(plan_type)) * 100  / COUNT(*) AS plan_type_null_pct,
(COUNT(*) - COUNT(amount)) * 100  / COUNT(*) AS amount_null_pct,
(COUNT(*) - COUNT(currency)) * 100  / COUNT(*) AS currency_null_pct,
(COUNT(*) - COUNT(status)) * 100  / COUNT(*) AS status_null_pct,
(COUNT(*) - COUNT(payment_method)) * 100  / COUNT(*) AS payment_method_null_pct
FROM billing;

-- CHECKING ON FEATURES TABLE 

SELECT * FROM features;

SELECT COUNT(feature_id)
FROM features
WHERE feature_id = '';

SELECT COUNT(available_plans)
FROM features
WHERE available_plans = '';

SELECT COUNT(*) AS TOTAL,
(COUNT(*) - COUNT(feature_id)) * 100  / COUNT(*) AS feature_id_null_pct,
(COUNT(*) - COUNT(feature_name)) * 100  / COUNT(*) AS feature_name_null_pct,
(COUNT(*) - COUNT(category)) * 100  / COUNT(*) AS category_date_null_pct,
(COUNT(*) - COUNT(launch_date)) * 100  / COUNT(*) AS launch_date_null_pct,
(COUNT(*) - COUNT(available_plans)) * 100  / COUNT(*) AS available_plans_null_pct
FROM features;

-- CHECKING ON FEEDBACK TABLE 

SELECT * FROM feedback;

SELECT COUNT(*) FROM feedback;

SELECT COUNT(comment)
FROM feedback
WHERE comment = '';

UPDATE feedback
SET comment = NULLIF(comment,'');

SELECT COUNT(*) AS TOTAL,
(COUNT(*) - COUNT(feedback_id)) * 100  / COUNT(*) AS feedback_id_null_pct,
(COUNT(*) - COUNT(user_id)) * 100  / COUNT(*) AS user_id_null_pct,
(COUNT(*) - COUNT(session_id)) * 100  / COUNT(*) AS session_id_null_pct,
(COUNT(*) - COUNT(submission_timestamp)) * 100  / COUNT(*) AS submission_timestamp_null_pct,
(COUNT(*) - COUNT(rating)) * 100  / COUNT(*) AS rating_null_pct,
(COUNT(*) - COUNT(comment_type)) * 100  / COUNT(*) AS comment_type_null_pct,
(COUNT(*) - COUNT(comment)) * 100  / COUNT(*) AS comment_null_pct,
(COUNT(*) - COUNT(feature_area)) * 100  / COUNT(*) AS feature_area_null_pct
FROM feedback;

-- CHECKING ON SESSIONS TABLE 

SELECT * FROM sessions;

SELECT DISTINCT device_type FROM sessions;

SELECT COUNT(*) FROM sessions;

SELECT COUNT(device_type)
FROM sessions
WHERE device_type = '';

SELECT device_type
FROM sessions
WHERE device_type = '';

UPDATE sessions
SET device_type = NULLIF(device_type,'\r');

SELECT COUNT(*) AS TOTAL,
(COUNT(*) - COUNT(session_id)) * 100  / COUNT(*) AS session_id_null_pct,
(COUNT(*) - COUNT(user_id)) * 100  / COUNT(*) AS user_id_null_pct,
(COUNT(*) - COUNT(login_time)) * 100  / COUNT(*) AS login_time_null_pct,
(COUNT(*) - COUNT(logout_time)) * 100  / COUNT(*) AS logout_time_null_pct,
(COUNT(*) - COUNT(device_type)) * 100  / COUNT(*) AS device_type_null_pct
FROM sessions;

-- CHECKING ON subscriptions TABLE 

SELECT * FROM subscriptions;


SELECT COUNT(*) FROM subscriptions;

SELECT COUNT(status)
FROM subscriptions
WHERE status = '';

UPDATE subscriptions
SET plan = NULLIF(plan,'');

SELECT COUNT(*) AS TOTAL,
(COUNT(*) - COUNT(subscription_id)) * 100  / COUNT(*) AS subscription_id_null_pct,
(COUNT(*) - COUNT(user_id)) * 100  / COUNT(*) AS user_id_null_pct,
(COUNT(*) - COUNT(plan)) * 100  / COUNT(*) AS plan_null_pct,
(COUNT(*) - COUNT(duration)) * 100  / COUNT(*) AS duration_null_pct,
(COUNT(*) - COUNT(start_date)) * 100  / COUNT(*) AS start_date_null_pct,
(COUNT(*) - COUNT(end_date)) * 100  / COUNT(*) AS end_date_null_pct,
(COUNT(*) - COUNT(status)) * 100  / COUNT(*) AS status_null_pct
FROM subscriptions;

-- CHECKING ON support_tickets TABLE 

SELECT * FROM support_tickets;


SELECT COUNT(*) FROM support_tickets;

SELECT COUNT(status)
FROM support_tickets
WHERE status = '';

UPDATE support_tickets
SET resolved_at = NULLIF(resolved_at,'');

SELECT COUNT(*) AS TOTAL,
(COUNT(*) - COUNT(ticket_id)) * 100  / COUNT(*) AS ticket_id_null_pct,
(COUNT(*) - COUNT(user_id)) * 100  / COUNT(*) AS user_id_null_pct,
(COUNT(*) - COUNT(feature)) * 100  / COUNT(*) AS feature_null_pct,
(COUNT(*) - COUNT(submitted_at)) * 100  / COUNT(*) AS submitted_at_null_pct,
(COUNT(*) - COUNT(priority)) * 100  / COUNT(*) AS priority_null_pct,
(COUNT(*) - COUNT(resolved)) * 100  / COUNT(*) AS resolved_null_pct,
(COUNT(*) - COUNT(resolved_at)) * 100  / COUNT(*) AS resolved_at_null_pct,
(COUNT(*) - COUNT(status)) * 100  / COUNT(*) AS status_at_null_pct
FROM support_tickets;

-- CHECKING ON system_metrics TABLE 

SELECT * FROM system_metrics;


SELECT COUNT(*) FROM system_metrics;

SELECT COUNT(response_time)
FROM system_metrics
WHERE response_time = '';

UPDATE system_metrics
SET error_rate = NULLIF(error_rate,'');

SELECT COUNT(*) AS TOTAL,
(COUNT(*) - COUNT(timestamp)) * 100  / COUNT(*) AS timestamp_null_pct,
(COUNT(*) - COUNT(active_users)) * 100  / COUNT(*) AS active_users_null_pct,
(COUNT(*) - COUNT(request_count)) * 100  / COUNT(*) AS request_count_null_pct,
(COUNT(*) - COUNT(error_count)) * 100  / COUNT(*) AS error_count_null_pct,
(COUNT(*) - COUNT(error_rate)) * 100  / COUNT(*) AS error_rate_null_pct,
(COUNT(*) - COUNT(cpu_usage)) * 100  / COUNT(*) AS cpu_usage_null_pct,
(COUNT(*) - COUNT(memory_usage)) * 100  / COUNT(*) AS memory_usage_null_pct,
(COUNT(*) - COUNT(response_time)) * 100  / COUNT(*) AS response_time_null_pct
FROM system_metrics;


-- CHECKING ON system_metrics TABLE 

SELECT * FROM users;


SELECT COUNT(*) FROM users;

SELECT COUNT(last_login_date)
FROM users
WHERE last_login_date = '';

UPDATE users
SET last_login_date = NULLIF(last_login_date,'');

SELECT COUNT(*) AS TOTAL,
(COUNT(*) - COUNT(user_id)) * 100  / COUNT(*) AS user_id_null_pct,
(COUNT(*) - COUNT(`Full name`)) * 100  / COUNT(*) AS Full_name_null_pct,
(COUNT(*) - COUNT(Email)) * 100  / COUNT(*) AS Email_count_null_pct,
(COUNT(*) - COUNT(location)) * 100  / COUNT(*) AS location_null_pct,
(COUNT(*) - COUNT(age)) * 100  / COUNT(*) AS age_null_pct,
(COUNT(*) - COUNT(plan_type)) * 100  / COUNT(*) AS plan_type_null_pct,
(COUNT(*) - COUNT(sign_up_date)) * 100  / COUNT(*) AS sign_up_date_null_pct,
(COUNT(*) - COUNT(is_active)) * 100  / COUNT(*) AS is_active_null_pct,
(COUNT(*) - COUNT(churn_date)) * 100  / COUNT(*) AS churn_date_null_pct,
(COUNT(*) - COUNT(last_login_date)) * 100  / COUNT(*) AS last_login_date_null_pct
FROM users;

SELECT last_login_date FROM users;

 /* -- COLUMN THAT WILL BE NEED FOR THIS PROJECT
  features.csv (Features Table)
  users.csv (Users Table) 
 subscriptions.csv (Subscriptions Table)
 sessions.csv (Sessions Table)
 feedback.csv (Feedback Table)
 activity_log.csv (Activity Log Table)   FACT TABLE
 
 */
 
 
 
 SELECT * FROM features;
 SELECT DISTINCT LAUNCH_DATE 
 FROM features;
 
 ALTER TABLE features
 MODIFY COLUMN LAUNCH_DATE DATE;
 
 SELECT DISTINCT available_plans 
 FROM features;
 
  SELECT feature_name,LAUNCH_DATE
 FROM features
 WHERE LAUNCH_DATE = '2025-02-20';
 
 -- WORKING ON USERS TABLE
 
 SELECT * FROM users;
 SELECT DISTINCT user_id FROM users;
 -- WORKING ON DATES COLUMN 
      -- sign_up_date COLUMN 
 SELECT sign_up_date
 FROM users
 WHERE sign_up_date IS NULL
 OR sign_up_date = ''
 OR sign_up_date NOT REGEXP '^[-]?[0-9]+(\.[0-9]+)?$';
 
 SELECT sign_up_date,
 STR_TO_DATE(TRIM(sign_up_date), '%m/%d/%Y') AS New_sign_up_date
 FROM USERS;
 
 ALTER TABLE USERS
 ADD COLUMN New_sign_up_date DATE;
 
 UPDATE USERS 
 SET New_sign_up_date = STR_TO_DATE(TRIM(sign_up_date), '%m/%d/%Y');
 
 SELECT New_sign_up_date FROM USERS;
 
 ALTER TABLE USERS 
 DROP COLUMN sign_up_date;
 
 ALTER TABLE USERS 
 CHANGE New_sign_up_date sign_up_date DATE;
 
 SELECT sign_up_date FROM USERS;
 
    -- last_login_date
    
    SELECT last_login_date FROM USERS;
    
    SELECT last_login_date FROM USERS
    WHERE last_login_date = '\r';
    
    UPDATE USERS 
    SET last_login_date = NULLIF(last_login_date,'\r');
    
    --  '\r'
    SELECT DISTINCT last_login_date 
    FROM USERS 
    WHERE last_login_date IS NULL
    OR last_login_date = ''
    OR last_login_date NOT REGEXP '^[-]?[0-9]+(\.[0-9]+)?$';
 
 SELECT DISTINCT last_login_date
FROM users
WHERE last_login_date IS NULL
   OR TRIM(last_login_date) = ''
   OR STR_TO_DATE(last_login_date, '%m/%d/%Y %H:%i') IS NULL
   AND STR_TO_DATE(last_login_date, '%Y-%m-%d %H:%i:%s') IS NULL;

 
 SELECT last_login_date,
 str_to_date(TRIM(last_login_date), '%m/%d/%Y %H:%i') AS New_last_login_date
 FROM USERS;
 
 ALTER TABLE USERS 
 ADD COLUMN New_last_login_date DATETIME;
 
 UPDATE USERS
 SET New_last_login_date = str_to_date(TRIM(last_login_date), '%m/%d/%Y %H:%i');
 
 SELECT last_login_date FROM USERS;
 
 ALTER TABLE USERS
 MODIFY COLUMN last_login_date DATETIME;
 
 ALTER TABLE USERS
 DROP COLUMN last_login_date;
 
 ALTER TABLE USERS
 CHANGE New_last_login_date last_login_date DATETIME;
 
 -- working on duplicate 
 
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

SELECT * 
FROM users
WHERE user_id IS NULL
   OR TRIM(user_id) = '';
   
DELETE 
FROM users
WHERE user_id IS NULL
OR TRIM(user_id) = '';

SELECT * FROM users;

SELECT DISTINCT LOCATION 
FROM USERS;

 -- WORKING ON subscriptions TABLE
 
 SELECT * FROM subscriptions;
 
  SELECT DISTINCT user_id FROM subscriptions;
 
 DESCRIBE subscriptions;
 
 ALTER TABLE subscriptions
 MODIFY COLUMN start_date DATE;
 
  ALTER TABLE subscriptions
 MODIFY COLUMN end_date DATE;
 
 SELECT DISTINCT STATUS FROM subscriptions;
 
 -- CHECKING FOR DUPLICATE
 
 SELECT user_id,PLAN,duration,start_date,end_date,status,COUNT(*)
 FROM subscriptions
 GROUP BY user_id,PLAN,duration,start_date,end_date,status
 HAVING COUNT(*) > 1;
 
  -- WORKING ON sessions TABLE
 
 SELECT * FROM sessions;
 
 SELECT DISTINCT user_id FROM sessions;
  SELECT DISTINCT device_type FROM sessions;
   ALTER TABLE sessions
 MODIFY COLUMN login_time DATETIME;
 
    ALTER TABLE sessions
 MODIFY COLUMN logout_time DATETIME;
 
 -- CHECKING FOR DUPLICATE
 
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
 
 
  -- WORKING ON feedback TABLE
 
 SELECT * FROM  feedback;
 SELECT DISTINCT user_id FROM feedback;
  SELECT DISTINCT RATING FROM feedback
  ORDER BY RATING DESC;
-- '\r'

 SELECT feature_area FROM feedback
 WHERE feature_area = '';
 
 SELECT DISTINCT comment_type FROM feedback;
 
 -- HERE I REPLACE ALL COLUMN WITH GOOD TO 4
  SELECT RATING FROM feedback
 WHERE RATING = 'GOOD';
 
SELECT RATING,
 REPLACE(RATING,'GOOD','4')
 FROM feedback;
 
 UPDATE feedback
SET rating = '4'
WHERE rating = 'Good';

 UPDATE feedback
 SET feature_area = NULLIF(feature_area, '\r');
 
 ALTER TABLE feedback
 MODIFY COLUMN submission_timestamp DATETIME;
 
  ALTER TABLE feedback
 MODIFY COLUMN RATING int;
 
-- WORKING ON DUPLICATE

SELECT * FROM  feedback;

SELECT user_id,session_id,submission_timestamp,COUNT(*)
FROM feedback
GROUP BY user_id,session_id,submission_timestamp
HAVING COUNT(*) > 1;
 
   -- WORKING ON activity_log TABLE
   
 SELECT * FROM activity_log;
 SELECT DISTINCT user_id FROM activity_log;
 
  SELECT DISTINCT activity_type FROM activity_log;
 
 ALTER TABLE activity_log
 MODIFY COLUMN timestamp DATETIME;
 
-- CHECKING FOR DUPLICATE 

SELECT * FROM activity_log;

SELECT session_id,user_id,timestamp,activity_type,COUNT(*)
FROM activity_log
GROUP BY session_id,user_id,timestamp,activity_type
HAVING COUNT(*) > 1;
 
 -- CREATING OF OUR ER DIAGRAM 
 -- DONE 
 
 -- ANALYSIS EDA
 
  -- features.csv (Features Table)
 -- users.csv (Users Table) 
-- subscriptions.csv (Subscriptions Table)
-- sessions.csv (Sessions Table)
-- feedback.csv (Feedback Table)
-- activity_log.csv (Activity Log Table)   FACT TABLE
 
/* -- PROBLEM 
1. FIND THE NUMBER OF PEOPLE WHO USED AT LEAST ONE OF THE NEW FEATURE FOR THE FIRST 7 DAYS OF LUNCH
2. CHECKS OR COMPARE WITH THE USERS WHO DIDNOT USE THE FEATURES AT ALL
3. WE WANT TO KNOW IF THIS NEW FEATURE MAKES USERS TO RETENE LONG AND ALSO IF IT ALLOW LONG TERM USERS ENGAGEMENT
4. WE WANT TO KNOW THE PERCENTAGE OF EFFECTS OF THE NEW FEATURE ON USERS

NEW FEATURES ARE Task Reminders Voice Assistant Custom Themes
LAUNCH DATE IS 2025-02-20 2025-02-20 2025-02-20
 */
 
 SELECT * FROM features;
 SELECT * FROM activity_log;
 
 SELECT DISTINCT activity_type FROM activity_log;
 
 ALTER TABLE activity_log ADD COLUMN mapped_activity_type VARCHAR(100);
 ALTER TABLE activity_log DROP COLUMN mapped_activity_type;
 
 
UPDATE activity_log
SET mapped_activity_type = CASE
    WHEN activity_type = 'task_reminder' THEN 'Task Reminders'
    WHEN activity_type = 'voice_assistant' THEN 'Voice Assistant'
    WHEN activity_type = 'custom_theme'   THEN 'Custom Themes'
    ELSE activity_type
END;

-- 1. FIND THE NUMBER OF PEOPLE WHO USED AT LEAST ONE OF THE NEW FEATURE FOR THE FIRST 7 DAYS OF LUNCH

 SELECT f.feature_name, COUNT(DISTINCT a.user_id) AS users_used_new_feature
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27'
GROUP BY f.feature_name;


 SELECT COUNT(DISTINCT a.user_id) AS users_used_new_feature
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27';


-- NUMBER OF PEOPLE WHO USE NEW FEATURE BY DAYNAME FOR THE FIRST SEVEN DAYS OF LUNCH

  SELECT DAYNAME(a.timestamp) AS day_name,
  COUNT(DISTINCT a.user_id) AS users_used_new_feature
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27'
  GROUP BY DAYNAME(a.timestamp)
ORDER BY MIN(DATE(a.timestamp));
 
 
 
/* SELECT distinct FEATURE FROM support_tickets;
 
SELECT f.feature_name,COUNT(DISTINCT a.user_id) users_used_new_feature
FROM features f
JOIN support_tickets s ON f.feature_name = s.feature
JOIN activity_log a ON s.user_id = a.user_id
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-26'
GROUP BY f.feature_name;
 */
 
 -- 2. CHECKS OR COMPARE WITH THE USERS WHO DIDNOT USE THE FEATURES AT ALL
 SELECT * FROM features;
 SELECT * FROM activity_log;


         -- THIS IS USE TO FIND EVERYONE THAT ARE ADOPTERS OF THE NEW FEATURES 
/*SELECT DISTINCT a.user_id
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27';*/

-- THIS GIVES US THE TOTAL NUMBER EVERYONE THAT ARE USERS BOTH ADOPTERS AND NON_ADOPTERS 
/* ALL_USERS AS (
SELECT DISTINCT user_id
FROM activity_log
WHERE timestamp BETWEEN '2025-02-20' AND '2025-02-27' */

           -- THIS IS USE TO FIND EVERYONE THAT ARE NON_ADOPTERS OF THE NEW FEATURES
           -- THE LEFT JOIN GIVE ALL USERS WHO ARE ADOPTERS OF THE FEATURES AND EVERYONE OTHER PERSONS ARE NULL AND NON_ADOP[TERS 
/*NON_ADOPTERS AS (
SELECT u.user_id
FROM ALL_USERS u
LEFT JOIN ADOPTERS a ON u.user_id = a.user_id
 WHERE a.user_id IS NULL*/


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

-- 3. WE WANT TO KNOW IF THIS NEW FEATURE MAKES USERS TO RETENE LONG AND ALSO IF IT ALLOW LONG TERM USERS ENGAGEMENT

SELECT DISTINCT LOGIN_TIME,
timestampdiff(WEEK, DATE('2025-02-20'), LOGIN_TIME) AS WEEK_NUM
FROM SESSIONS
ORDER BY WEEK_NUM;


 SELECT * FROM features;
 SELECT * FROM activity_log;
SELECT * FROM USERS;

-- Adopters - users who actually used the new feature after it was launched.

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



 SELECT * FROM users;
 SELECT * FROM subscriptions;
SELECT * FROM sessions;
SELECT * FROM feedback;
SELECT * FROM activity_log;

-- 4. WE WANT TO KNOW THE PERCENTAGE OF EFFECTS OF THE NEW FEATURE ON USERS
 
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
 
 
 
 
 -- ------------------- CREATING VIEW FOR USE IN POWER BI --------------------------------------------
 SELECT * FROM activity_log;
 SELECT * FROM users;
 SELECT * FROM features;
 SELECT * FROM sessions;
 
 
 CREATE VIEW USERS_ENGAGEMENT AS
 WITH adopters AS (
 SELECT DISTINCT a.user_id
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27'
),

non_adopters AS (
   SELECT DISTINCT u.user_id
   FROM USERS u
   WHERE u.user_id NOT IN (SELECT user_id FROM adopters)
   AND u.sign_up_date <= '2025-02-20'
),

weekly_activity AS (
 SELECT user_id,
  timestampdiff(WEEK, DATE('2025-02-20'), LOGIN_TIME) AS week_num
 FROM sessions
 WHERE LOGIN_TIME >= '2025-02-20'
),

adopter_retention AS (
 SELECT w.week_num ,
 COUNT(DISTINCT w.user_id) AS adopters_retained_users,
 (SELECT COUNT(*) FROM adopters)  AS adopters_cohort_size
 FROM weekly_activity w
 JOIN adopters a ON w.user_id = a.user_id
 GROUP BY w.week_num
),

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



CREATE VIEW  feature_effect_percent AS
 WITH adopters AS (
 SELECT DISTINCT a.user_id
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27'
),

non_adopters AS (
   SELECT DISTINCT u.user_id
   FROM USERS u
   WHERE u.user_id NOT IN (SELECT user_id FROM adopters)
   AND u.sign_up_date <= '2025-02-20'
),

weekly_activity AS (
 SELECT user_id,
  timestampdiff(WEEK, DATE('2025-02-20'), LOGIN_TIME) AS week_num
 FROM sessions
 WHERE LOGIN_TIME >= '2025-02-20'
),

adopter_retention AS (
 SELECT w.week_num ,
 COUNT(DISTINCT w.user_id) AS adopters_retained_users,
 (SELECT COUNT(*) FROM adopters)  AS adopters_cohort_size
 FROM weekly_activity w
 JOIN adopters a ON w.user_id = a.user_id
 GROUP BY w.week_num
),

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


-- TOAL USERS BEFORE LUNCH
SELECT COUNT(DISTINCT user_id) AS total_users
FROM users
WHERE sign_up_date <= '2025-02-20';


-- Adopters (First 7 Days)

 SELECT COUNT(DISTINCT a.user_id) AS users_used_new_feature
FROM features f
JOIN activity_log a 
  ON a.mapped_activity_type = f.feature_name
WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
  AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27';
  
  
-- Non-Adopters (First 7 Days)

WITH adopters AS (
    SELECT DISTINCT a.user_id
    FROM features f
    JOIN activity_log a 
      ON a.mapped_activity_type = f.feature_name
    WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
      AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27'
),
all_users AS (
    SELECT DISTINCT user_id
    FROM activity_log
    WHERE timestamp BETWEEN '2025-02-20' AND '2025-02-27'
)
SELECT COUNT(*) AS non_adopters_first_7_days
FROM all_users u
LEFT JOIN adopters a ON u.user_id = a.user_id
WHERE a.user_id IS NULL;


-- Adopters vs Non-Adopters (%)

WITH adopters AS (
    SELECT DISTINCT a.user_id
    FROM features f
    JOIN activity_log a 
      ON a.mapped_activity_type = f.feature_name
    WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
      AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27'
),
all_users AS (
    SELECT DISTINCT user_id
    FROM activity_log
    WHERE timestamp BETWEEN '2025-02-20' AND '2025-02-27'
),
 COUNTS AS (
SELECT 
(SELECT COUNT(*) FROM adopters) AS adopters_count,
(SELECT COUNT(*) FROM all_users) AS total_users

) SELECT 
    adopters_count,
    (total_users - adopters_count) AS non_adopters_count,
    ROUND(adopters_count / total_users * 100, 2) AS adopters_percentage,
    ROUND((total_users - adopters_count) / total_users * 100, 2) AS non_adopters_percentage
    FROM COUNTS;

CREATE VIEW `Adopters vs Non-Adopters` AS
WITH adopters AS (
    SELECT DISTINCT a.user_id
    FROM features f
    JOIN activity_log a 
      ON a.mapped_activity_type = f.feature_name
    WHERE f.feature_name IN ('Task Reminders','Voice Assistant','Custom Themes')
      AND a.timestamp BETWEEN '2025-02-20' AND '2025-02-27'
),
all_users AS (
    SELECT DISTINCT user_id
    FROM activity_log
    WHERE timestamp BETWEEN '2025-02-20' AND '2025-02-27'
),
 COUNTS AS (
SELECT 
(SELECT COUNT(*) FROM adopters) AS adopters_count,
(SELECT COUNT(*) FROM all_users) AS total_users

) SELECT 
    adopters_count,
    (total_users - adopters_count) AS non_adopters_count,
    ROUND(adopters_count / total_users * 100, 2) AS adopters_percentage,
    ROUND((total_users - adopters_count) / total_users * 100, 2) AS non_adopters_percentage
    FROM COUNTS;
