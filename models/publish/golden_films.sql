{{
  config(
    materialized = "table",
    schema = "personal"
  )
}}

select
  films.*,
  'golden' as type
from {{ ref('films_core') }} films