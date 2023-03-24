{{ config(
    materialized='table'
 ) }}

select * from {{source('web_tracking','pageviews')}}