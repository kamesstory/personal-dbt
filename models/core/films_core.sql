{{
  config(
    materialized = "table",
    schema = "core"
  )
}}

select
  films.*,
  'published' as status
from {{ source('public', 'films') }}
