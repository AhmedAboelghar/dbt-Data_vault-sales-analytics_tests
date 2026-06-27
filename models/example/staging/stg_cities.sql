
with source as (
    select * from {{ ref('DIM_CITY') }}
),

renamed as (
    select
        cast("City_Key" as integer) as city_key,
        cast("City_Name" as varchar) as city_name,
        cast("State_Name" as varchar) as state_name,
        cast("Region_Name" as varchar) as region_name,
        cast("Country" as varchar) as country
    from source
)

select * from renamed