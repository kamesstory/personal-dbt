{{ override_config_for_census_test() }}

select
  films.*,
  'published' as status,
  {{ "'" ~ config.get('schema') ~ "'" }} as config_schema
from {{ source('public', 'films') }}
