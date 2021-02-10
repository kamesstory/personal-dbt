select email_domain
from {{ ref('golden_teams') }}
where is_vip is True