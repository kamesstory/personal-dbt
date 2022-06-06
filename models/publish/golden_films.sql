{{
  config(
    materialized = "table",
    schema = "publish"
  )
}}

{{ override_config_for_census_test() }}

select
  films.*,
  'golden' as type
from {{ ref('films_core') }} films
