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
),

-- PART 2: grouping events into sessions
data2 as (
  select
    user_id,
    "time",
    sum(new_session) over (partition by user_id order by time asc rows unbounded preceding) as user_session_number,
    min(time) over (partition by user_id order by time asc rows unbounded preceding) as user_session_start,
    sum(new_day) over (partition by user_id order by time asc rows unbounded preceding) as user_day_number
  from data
),

-- PART 3: defining each session's start and end time
data3 as (
  select
    user_id,
    "time",
    user_session_number,
    user_day_number,
    min(time) over (partition by user_id, user_session_number order by time asc rows unbounded preceding) as session_start,
    max(time) over (partition by user_id, user_session_number order by time asc rows unbounded preceding) as session_end
  from data2
),

-- PART 4: calculating session durations
data4 as (
  select
    user_id,
    user_session_number,
    max(user_day_number) as num_days,
    min(time) as session_start,
    max(session_end) as session_end,
    round(((extract(epoch from max(session_end)) - extract(epoch from max(session_start))) / 60)::decimal, 1) as session_duration_in_minutes
  from data3
  inner join {{ source('marker', 'users') }} on users.id = user_id
  group by 1,2
)

select * from data4


-- PART 5: aggregating session durations and other calculations (hours_per_week, num_days_used_product, hours_per_day, longest_weekly_session_in_minutes)
--   select
--     session_durations.user_id,
--     email,
--     round(sum(session_duration_in_minutes) / 60, 1) as hours,
--     max(num_days) as num_days_used_product,
--     round(round(sum(session_duration_in_minutes) / 60, 1) / max(num_days), 1) as hours_per_day,
--     max(session_duration_in_minutes) as longest_session_in_minutes
--   from session_durations
--   group by 1,2
--   having sum(session_duration_in_minutes) > 20
--   order by 3 desc;