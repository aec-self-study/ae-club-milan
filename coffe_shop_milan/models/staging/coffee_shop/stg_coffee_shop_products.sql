{{ config(
    materialized='table'
 ) }}

select * from `analytics-engineers-club.coffee_shop.products`