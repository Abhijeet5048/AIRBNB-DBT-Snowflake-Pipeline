SELECT 
    HOST_ID,
    HOST_NAME,
    dbt_valid_from,
    dbt_valid_to
FROM AIRBNB.GOLD.DIM_HOSTS
WHERE HOST_ID = 1
ORDER BY dbt_valid_from;