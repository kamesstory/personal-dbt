{{
  config(
    materialized = "table"
  )
}}

select
  films.*,
  'golden' as type
from {{ ref('films_core') }} films

{{ override_config_for_census_test() }}
