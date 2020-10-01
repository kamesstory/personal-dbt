select
 id,
 case
   when email similar to '%(gmail|yahoo|outlook|hotmail)%' then 'personal'
   else 'business'
 end as email_type
from {{ source('marker', 'users') }}