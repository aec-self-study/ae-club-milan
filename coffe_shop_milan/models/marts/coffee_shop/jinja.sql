{{ config( MATERIALIZED="table" )}}

{% set categories = ["coffee_beans", "merch", "brewing_supplies"] %}

select
  date_trunc(created_at, month) as date_month,
  {% for category in categories %} 
  sum(case when category = '{{category | replace("_"," ")}}' then total end) as {{category}}_amount,
  {% endfor %}   
from {{ ref('sales') }}
group by 1
