with raw_stats as (
    select 
        min("Row ID") as min_id, 
        max("Row ID") as max_id
    from public.fact_orders
),
stg_stats as (
    select 
        min(row_id) as min_id, 
        max(row_id) as max_id
    from {{ ref('stg_orders') }}
)

select *
from raw_stats, stg_stats
where raw_stats.min_id <> stg_stats.min_id
   or raw_stats.max_id <> stg_stats.max_id