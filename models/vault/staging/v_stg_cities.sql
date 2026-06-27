with source as (
    select * from {{ ref('DIM_CITY') }}
)

select
    *,
    -- Hub Hash Key
    md5(coalesce(cast("City_Key" as text), '-1')) as city_hash_key,
    
    current_timestamp as load_date,
    'POSTGRES_DIM_CITY' as record_source
from source
where "City_Key" is not null