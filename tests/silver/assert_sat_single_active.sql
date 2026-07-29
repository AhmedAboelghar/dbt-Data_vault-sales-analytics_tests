select party_pk, count(*) 
from {{ ref('sat_name') }}
where record_status = 'Active' 
group by party_pk 
having count(*) > 1