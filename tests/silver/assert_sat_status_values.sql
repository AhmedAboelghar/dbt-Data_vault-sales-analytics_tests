select * 
from {{ ref('sat_name') }}
where record_status not in ('Active', 'expired')