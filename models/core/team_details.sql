select
    *,
    -- extract preferences JSON
    json_extract_path_text(preferences, 'self_upgrade') as self_upgrade,
    json_extract_path_text(preferences, 'public_sharing') as public_sharing,
    json_extract_path_text(preferences, 'members_can_invite') as members_can_invite
from {{ source('marker', 'teams') }}

union
 select 9999 as id, 
 'oops' as name, 'band.ly' as email_domain, 
 getdate() as created_at, 
 getdate() as updated_at, 
 0 as active_user_count, 
 '{}' as preferences, 
 'true' as self_updgrade, 
 'true' as public_sharing, 
 'true' as members_can_invite
