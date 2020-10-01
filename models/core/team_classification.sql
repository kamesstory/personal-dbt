select
 id,
 active_user_count > 10 as is_vip
from {{ source('marker', 'teams') }}