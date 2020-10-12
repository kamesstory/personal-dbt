WITH sessions AS (
    --for each session, create a unique session id by concatenating the user_id with its sequential session number
    --define the start timestamp and (effective) end timestamp for each session 
    SELECT
        ROW_NUMBER() OVER (PARTITION BY lag.user_id ORDER BY lag.time) || '-' || lag.user_id AS session_id
        , lag.user_id
        , lag.idle_minutes as idle_minutes_prior
        , lag.time AS session_start
        , LEAD(lag.time) OVER (PARTITION BY lag.user_id ORDER BY lag.time) AS next_session_start
        , DATEDIFF(minutes, session_start, next_session_start) AS session_length_in_minutes
    --count the number of idle minutes between each track event by user_id
    FROM (
        SELECT 
            user_id
            , "time"
            , DATEDIFF(minutes, LAG(time) OVER(PARTITION BY user_id ORDER BY time), time) AS idle_minutes
        FROM {{ source('marker', 'events') }}
    ) AS lag
    --define a new session when at least 120 minutes have elapsed since the last event (or when this is the first event) for each user_id
    WHERE (lag.idle_minutes > 120 OR lag.idle_minutes IS NULL)
)


select * from sessions
