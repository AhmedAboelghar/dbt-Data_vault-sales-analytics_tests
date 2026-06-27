with source as (
    select * from {{ ref('DIM_Customer') }}
)

select
    *,
    -- Hub Hash Keys
    md5(coalesce(cast("Customer_Key" as text), '-1')) as customer_hash_key,
    md5(coalesce(cast("City_Key" as text), '-1')) as city_hash_key,

    -- Link Hash Key (Customer <-> City)
    md5(coalesce(cast("Customer_Key" as text), '-1') || '_' || coalesce(cast("City_Key" as text), '-1')) as link_customer_city_hash_key,

    current_timestamp as load_date,
    'POSTGRES_DIM_CUSTOMER' as record_source
from source
where "Customer_Key" is not null