{{
    config(
        materialized = 'ephemeral'
    )
}}

with bookings as 
(
    select 
        BOOKING_ID,
        BOOKING_DATE,
        BOOKING_STATUS,
        CREATED_AT
    from
        {{ ref('silver_bookings') }}
)
select * from bookings
