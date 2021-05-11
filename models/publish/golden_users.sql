select
    ud.*,
    'red' as favorite_color,
    {{ dbt_utils.star(from=ref('user_stats'), except=["user_id"]) }},
    {{ dbt_utils.star(from=ref('user_classification'), except=["id"]) }}
from {{ ref('user_details') }} ud
left join {{ ref('user_stats') }} us on us.user_id = ud.id
left join {{ ref('user_classification') }} uc on uc.id = ud.id