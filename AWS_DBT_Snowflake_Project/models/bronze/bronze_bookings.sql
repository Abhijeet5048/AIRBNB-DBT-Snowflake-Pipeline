{{ 
    config(
        materialized='incremental',
        unique_key='BOOKING_ID'
    ) 
}}

WITH source_data AS (

    SELECT *
    FROM {{ source('staging', 'bookings') }}

    {% if is_incremental() %}
    WHERE CREATED_AT >= (
        SELECT COALESCE(MAX(CREATED_AT), '1900-01-01')
        FROM {{ this }}
    )
    {% endif %}

),

ranked AS (
    
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY BOOKING_ID
            ORDER BY CREATED_AT DESC
        ) AS rn
    FROM source_data

)

SELECT *
FROM ranked
WHERE rn = 1


{# {{ config(materialized = 'incremental') }}

select * from {{ source('staging', 'bookings') }}

{% if is_incremental() %}
  where CREATED_AT > (select coalesce(max(CREATED_AT), '1900-01-01')  from {{ this }})
{% endif %} #}