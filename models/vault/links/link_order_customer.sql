{{ config(materialized='incremental') }}

with source_data as (
    select distinct
        "Order ID" as order_id,
        "Customer ID" as customer_id,
        current_timestamp as load_date,
        'dbeaver_fact_orders' as record_source
    from {{ source('raw_sales', 'fact_orders') }}
    where "Order ID" is not null and "Customer ID" is not null
)

select
    md5(trim(order_id) || '||' || trim(customer_id)) as hk_link_order_customer,
    md5(trim(order_id)) as hk_order,
    md5(trim(customer_id)) as hk_customer,
    load_date,
    record_source
from source_data

{% if is_incremental() %}
where md5(trim(order_id) || '||' || trim(customer_id)) not in (select hk_link_order_customer from {{ this }})
{% endif %}