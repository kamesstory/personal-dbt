select
    *,
    -- extract preferences JSON
    json_extract_path_text(preferences, 'self_upgrade') as self_upgrade,
    json_extract_path_text(preferences, 'public_sharing') as public_sharing,
    json_extract_path_text(preferences, 'members_can_invite') as members_can_invite
from {{ source('marker', 'teams') }}