{{ config(materialized='incremental') }}

with source_data as (
    select distinct
        "Customer ID" as customer_id,
        current_timestamp as load_date,
        'dbeaver_fact_orders' as record_source
    from {{ source('raw_sales', 'fact_orders') }}
    where "Customer ID" is not null
)

select
    md5(trim(customer_id)) as hk_customer,
    customer_id,
    load_date,
    record_source
from source_data

{% if is_incremental() %}
where md5(trim(customer_id)) not in (select hk_customer from {{ this }})
{% endif %}