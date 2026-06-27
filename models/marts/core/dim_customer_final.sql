
with customers as (
    select * from {{ ref('stg_customers') }}
),

cities as (
    select * from {{ ref('stg_cities') }}
),

final as (
    select
        c.customer_key,
        c.customer_id,
        c.customer_name,
        ci.city_name,
        ci.state_name,
        ci.region_name,
        ci.country
    from customers c
    left join cities ci on c.city_key = ci.city_key
)

select * from final