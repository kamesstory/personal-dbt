{{
  config(
    tags=["core"]
  )
}}

select
  films.*,
  'published' as status,
  {{ "'" ~ config.get('schema') ~ "'" }} as config_schema
from {{ ref('films') }}

{{ override_config_for_census_test() }}
