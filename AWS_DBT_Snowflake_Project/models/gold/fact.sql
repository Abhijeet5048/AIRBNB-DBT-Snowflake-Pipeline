{% set configs = [
    {
        "table" : "AIRBNB.GOLD.OBT",
        "columns": "GOLD_OBT.BOOKING_ID, GOLD_OBT.LISTING_ID, GOLD_OBT.HOST_ID, GOLD_OBT.TOTAL_BOOKING_AMOUNT, GOLD_OBT.SERVICE_FEE, GOLD_OBT.CLEANING_FEE, GOLD_OBT.ACCOMMODATES, GOLD_OBT.BEDROOMS, GOLD_OBT.BATHROOMS, GOLD_OBT.PRICE_PER_NIGHT, GOLD_OBT.RESPONSE_RATE",
        "alias" : "GOLD_OBT",
    },
    {
        "table" : ref('dim_listings'),
        "columns": "",
        "alias" : "DIM_listings",
        "join_condition" : "GOLD_OBT.listing_id = DIM_listings.listing_id"
    },
    {
        "table" : ref('dim_hosts'),
        "columns": "",
        "alias" : "DIM_hosts",
        "join_condition" : "GOLD_OBT.host_id = DIM_hosts.host_id"
    }
]%}

select  
        {{ configs[0].columns }}

from
    {% for config in configs %}
    {% if loop.first %}
        {{ config['table']}} as {{ config['alias'] }}
    {% else %}
        left join {{ config['table'] }} as {{ config['alias'] }}
        on {{ config['join_condition'] }}
        {% endif %}
    {% endfor %}