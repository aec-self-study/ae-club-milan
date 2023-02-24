

  create or replace view `aec-students`.`dbt_milan`.`customers_ref`
  OPTIONS()
  as Select *
from `analytics-engineers-club`.`coffee_shop`.`customers`;

