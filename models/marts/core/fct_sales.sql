
with orders as (
    select * from {{ ref('stg_orders') }}
),

final as (
    select
        row_id,
        order_id,
        customer_key,
        product_key,
        order_date,
        ship_date,
        ship_mode,
        shipping_days,
        quantity,
        unit_price,
        sales_amount,
        discount_percentage,
        revenue,
        total_cost,
        profit,
        -- حساب هامش الربح كنسبة مئوية بدقة (Profit Margin %)
        case 
            when revenue = 0 then 0
            else round((profit / revenue) * 100, 2)
        end as profit_margin_percentage
    from orders
)

select * from final