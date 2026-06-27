
with source as (
    select * from {{ ref('DIM_Customer') }}
),

renamed as (
    select
        cast("Customer_Key" as integer) as customer_key,
        cast("Customer ID" as varchar) as customer_id,
        cast("Customer Name" as varchar) as customer_name,
        cast("City_Key" as integer) as city_key
    from source
)

select * from renamed