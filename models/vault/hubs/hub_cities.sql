{{ config(materialized='incremental') }}

with source_data as (
    select distinct
        "Product ID" as product_id,
        current_timestamp as load_date,
        'dbeaver_fact_orders' as record_source
    from {{ source('raw_sales', 'fact_orders') }}
    where "Product ID" is not null
)

select
    md5(trim(product_id)) as hk_product,
    product_id,
    load_date,
    record_source
from source_data

{% if is_incremental() %}
where md5(trim(product_id)) not in (select hk_product from {{ this }})
{% endif %}