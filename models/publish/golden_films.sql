{{
  config(
    materialized = "table",
    schema = "publish"
  )
}}

select
  films.*,
  'golden' as type
from {{ ref('films_core') }} films