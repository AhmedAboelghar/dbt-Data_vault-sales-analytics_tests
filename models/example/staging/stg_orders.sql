
with source as (
    select * from {{ source('raw_sales', 'fact_orders') }}
),

renamed as (
    select
        cast("Row ID" as integer) as row_id,
        cast("Order ID" as varchar) as order_id,
        cast("Customer_Key" as integer) as customer_key,
        cast("Product_Key" as integer) as product_key,
        cast("Order Date" as date) as order_date,
        cast("Ship Date" as date) as ship_date,
        cast("Ship Mode" as varchar) as ship_mode,
        cast("Shipping_Days" as integer) as shipping_days,
        cast("Quantity" as integer) as quantity,
        cast("Unit_Price" as numeric(10,2)) as unit_price,
        cast("Sales" as numeric(10,2)) as sales_amount,
        cast("Discount" as numeric(5,2)) as discount_percentage,
        cast("Revenue" as numeric(10,2)) as revenue,
        cast("Cost" as numeric(10,2)) as total_cost,
        cast("Profit" as numeric(10,2)) as profit,
        -- ترقيم السطور المتكررة بناء على الـ Row ID لاختيار سطر واحد فريد منها
        row_number() over (partition by "Row ID" order by "Row ID") as row_num
    from source
    where "Customer_Key" is not null  -- <--- تصفية الـ 4 سطور الفاضية لمنع الـ null failure
)

select 
    row_id, order_id, customer_key, product_key, order_date, ship_date,
    ship_mode, shipping_days, quantity, unit_price, sales_amount,
    discount_percentage, revenue, total_cost, profit
from renamed
where row_num = 1 -- <--- اختيار السطر الفريد فقط ومنع التكرار