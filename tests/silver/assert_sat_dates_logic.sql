select start_date, end_date 
from {{ ref('sat_name') }}
where start_date > end_date