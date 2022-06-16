{{
  config(
    materialized = "table"
  )
}}

select
  films.*,
  'golden' as film_type,
  'TRUE' as is_vip
from {{ ref('films_core') }} films

{{ override_config_for_census_test() }}
