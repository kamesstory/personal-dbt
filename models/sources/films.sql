select
  *
from {{ source('public', 'films') }}