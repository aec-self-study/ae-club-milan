{{ config(
    materialized='table'
 ) }}

WITH
  pageview_with_stiched_user_id AS 
(
SELECT
    *,
    COALESCE (FIRST_VALUE(customer_id IGNORE NULLS) OVER (PARTITION BY visitor_id ORDER BY visitor_id ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),visitor_id) AS user_id
FROM
  {{ ref('stg_web_tracking__pageviews') }} as pageviews
),

  session_calculator as
(
SELECT
  *,
  if (TIMESTAMP_DIFF (timestamp,LAG(timestamp) OVER (PARTITION BY user_id ORDER BY timestamp ASC), SECOND)>1800, 1, 0) AS session_number_increment
FROM
  pageview_with_stiched_user_id
)

SELECT *,
  ABS(FARM_FINGERPRINT(USER_ID || SUM(session_number_increment) OVER (PARTITION BY user_id ORDER BY TIMESTAMP ASC))) as session_id
FROM session_calculator
order by visitor_id, timestamp


