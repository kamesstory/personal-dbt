{{
  config(
    materialized = "table"
  )
}}

{{ override_config_for_census_test() }}

select
  films.*,
  'golden' as type
from {{ ref('films_core') }} films
