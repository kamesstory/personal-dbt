-- PART 1: data prep on each user's events to find time since their last event, if the next event constitutes a new session and is on a new day than the previous
with data as (
  select
    user_id,
    "time",
    round(((extract(epoch from time) - extract(epoch from lag(time) over (partition by user_id order by time asc))) / 60)::decimal, 1) minutes_since_last_event,
    case
      when coalesce(round(((extract(epoch from time) - extract(epoch from lag(time) over (partition by user_id order by time asc))) / 60)::decimal, 1), 30) >= 30 then 1
      else 0
    end as new_session,
    case
      when date_trunc('day', time) <> date_trunc('day', lag(time) over (partition by user_id order by time asc)) then 1
      when lag(time) over (partition by user_id order by time asc) is null then 1
      else 0
    end as new_day
  from {{ source('marker', 'events') }}
  order by 2, 1 asc
)

select *
from data