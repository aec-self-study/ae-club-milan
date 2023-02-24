
  
    

    create or replace table `aec-students`.`dbt_milan`.`customers`
    
    
    OPTIONS()
    as (
      

select * from `analytics-engineers-club.coffee_shop.customers`
limit 9000
    );
  