select row_id, count(*) 
from {{ ref('stg_orders') }}
group by row_id 
having count(*) > 1