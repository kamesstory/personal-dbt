select
 id,
 first_name,
 last_name,
 email,
 case
   when email similar to '%(gmail|yahoo|outlook|hotmail)%' then 'personal' --simplified list
   else 'business'
 end as email_type
from {{ source('marker', 'users') }}