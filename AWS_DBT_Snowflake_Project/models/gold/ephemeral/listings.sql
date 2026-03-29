{{
    config(
        materialized = 'ephemeral'
    )
}}

with listings as 
(
    select 
        LISTING_ID,
        PROPERTY_TYPE,
        ROOM_TYPE,
        CITY,
        COUNTRY,
        PRICE_PER_NIGHT_TAG,
        CREATED_AT as LISTINGS_CREATED_AT
    from
        {{ ref('silver_listings') }}
)
select * from listings