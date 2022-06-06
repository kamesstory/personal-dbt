{{
  config(
    materialized = "table",
    alias = "golden_films_aliased"
  )
}}

{{ override_config_for_census_test() }}

select
  films.*,
  'golden' as type
from {{ ref('films_core') }} films
