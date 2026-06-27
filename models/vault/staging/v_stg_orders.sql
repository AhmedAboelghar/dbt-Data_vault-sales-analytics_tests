with source as (
    select * from {{ source('raw_sales', 'fact_orders') }}
),

deduplicated as (
    select *,
        row_number() over (partition by "Row ID" order by "Row ID") as row_num
    from source
    where "Customer_Key" is not null
),

final_orders as (
    select * from deduplicated
    where row_num = 1
)

select
    *,
    -- Hub Hash Keys
    md5(coalesce(cast("Order ID" as text), '-1')) as order_hash_key,
    md5(coalesce(cast("Customer_Key" as text), '-1')) as customer_hash_key,

    -- Link Hash Key (Order <-> Customer)
    md5(coalesce(cast("Order ID" as text), '-1') || '_' || coalesce(cast("Customer_Key" as text), '-1')) as link_order_customer_hash_key,

    current_timestamp as load_date,
    'POSTGRES_FACT_ORDERS' as record_source
from final_orders