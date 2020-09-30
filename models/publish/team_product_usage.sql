select
 team_id,
 teams.name as team_name,
 email_domain,
 count(1) as action_count,
 count(distinct user_id) as user_count,

 min(time) as first_event,
 max(time) as last_event,
 round(((extract(epoch from max(time)::timestamp) - extract(epoch from min(time)::timestamp)) / 86400.00)::numeric,4) as days_between_first_last_events,
 round(((extract(epoch from getdate()) - extract(epoch from max(time)::timestamp)) / 86400.00)::numeric,4) as days_since_last_event,

{{ count_with_filter('events.name', 'Add Image') }} as add_image,
{{ count_with_filter('events.name', 'Delete Image') }} as delete_image,
{{ count_with_filter('events.name', 'Auto-Organize Canvas') }} as auto_organize_canvas,
{{ count_with_filter('events.name', 'New Canvas') }} as new_canvas,
{{ count_with_filter('events.name', 'Share Canvas') }} as share_canvas

from {{ source('marker', 'events') }}
left join {{ source('marker', 'teams') }} on team_id = teams.id
group by 1,2,3
