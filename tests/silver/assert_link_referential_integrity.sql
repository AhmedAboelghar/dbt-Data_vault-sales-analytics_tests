select l.customer_id
from {{ ref('link_name') }} l
left join {{ ref('hub_name') }} h on l.customer_id = h.customer_id
where h.customer_id is null