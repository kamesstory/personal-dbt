select
  films.*,
  'published' as status,
  {{ config.get('schema') }} as config_schema
from {{ source('public', 'films') }}
