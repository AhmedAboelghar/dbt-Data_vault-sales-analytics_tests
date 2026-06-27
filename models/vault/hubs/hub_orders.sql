{{ config(materialized='incremental') }}

with source_data as (
    select distinct
        "Order ID" as order_id,
        current_timestamp as load_date,
        'dbeaver_fact_orders' as record_source
    from {{ source('raw_sales', 'fact_orders') }}
    where "Order ID" is not null
)

select
    md5(trim(order_id)) as hk_order,
    order_id,
    load_date,
    record_source
from source_data

{% if is_incremental() %}
where md5(trim(order_id)) not in (select hk_order from {{ this }})
{% endif %}