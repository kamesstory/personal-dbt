select
    td.*,
    {{ dbt_utils.star(from=ref('team_classification'), except=["id"]) }},
    {{ dbt_utils.star(from=ref('team_stats'), except=["id"]) }}
from {{ ref('team_details') }} td
join {{ ref('team_classification') }} using (id)
join {{ ref('team_stats') }} using (id)