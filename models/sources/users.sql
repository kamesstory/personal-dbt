select 
  users.*
  , teams.email_domain as team_domain
from {{ source('marker', 'users') }}
left join {{ source('marker', 'teams') }} on team_id = teams.id