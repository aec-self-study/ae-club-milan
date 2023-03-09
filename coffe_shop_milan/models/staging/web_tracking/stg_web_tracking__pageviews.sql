{{ config(
    materialized='table'
 ) }}

select * from `analytics-engineers-club.web_tracking.pageviews`