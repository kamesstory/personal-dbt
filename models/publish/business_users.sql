select *
from {{ ref('users') }}
where email_type = 'business'