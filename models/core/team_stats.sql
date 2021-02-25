select
 team_id as id,
 count(1) as action_count,
 count(distinct user_id) as user_count,

 min(time) as first_event,
 max(time) as last_event,
 round(((extract(epoch from max(time)::timestamp) - extract(epoch from min(time)::timestamp)) / 86400.00)::numeric,4) as days_between_first_last_events,
 round(((extract(epoch from getdate()) - extract(epoch from max(time)::timestamp)) / 86400.00)::numeric,4) as days_since_last_event,

{{ count_with_filter('events.name', 'Add Image') }} as images_added,
{{ count_with_filter('events.name', 'Delete Image') }} as images_deleted,
{{ count_with_filter('events.name', 'Auto-Organize Canvas') }} as auto_organize_canvas,
{{ count_with_filter('events.name', 'New Canvas') }} as canvas_created,
{{ count_with_filter('events.name', 'Share Canvas') }} as canvas_shared

from {{ source('marker', 'events') }}
group by 1

union 
 select 9999 as id,
 0 as action_count,
 0 as user_count,
 getdate() as first_event,
 getdate() as last_event,
 0 as days_between_first_last_events,
 0 as days_since_last_event,
 0 as images_added,
 0 as images_deleted,
 0 as auto_organize_canvas,
 0 as canvas_created,
 0 as canvas_shared