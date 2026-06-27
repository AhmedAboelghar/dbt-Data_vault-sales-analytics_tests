{{ config(materialized='incremental') }}

with source_data as (
    select distinct
        "Customer ID" as customer_id,
        "Customer Name" as customer_name,
        "Segment_Key" as segment_key,
        "City_Key" as city_key,
        current_timestamp as load_date,
        'dbeaver_dim_customer' as record_source
    from {{ source('raw_sales', 'DIM_Customer') }}
    where "Customer ID" is not null
),

hashed_data as (
    select
        md5(trim(customer_id)) as hk_customer,
        -- السطر الجاي ده هو العقل المدبر للـ Satellite (الـ Hash Diff)
        md5(coalesce(trim(customer_name), '') || '||' || coalesce(cast(segment_key as varchar), '') || '||' || coalesce(cast(city_key as varchar), '')) as hash_diff,
        customer_name,
        segment_key,
        city_key,
        load_date,
        record_source
    from source_data
)

select * from hashed_data

{% if is_incremental() %}
-- الشرط ده معناه: لو العميل موجود بنفس تفاصيله القديمة بالظبط (نفس الـ Hash Diff)، ماتنزلش سطر جديد
where hash_diff not in (select hash_diff from {{ this }} where hk_customer = hashed_data.hk_customer)
{% endif %}