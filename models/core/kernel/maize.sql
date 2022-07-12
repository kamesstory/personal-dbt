{{
  config(
    tags=["maize", "core"]
  )
}}

select 'maize' as plant

{{ override_config_for_census_test() }}