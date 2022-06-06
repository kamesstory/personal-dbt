select
  films.*,
  'published' as status
from {{ source('public', 'films') }}
