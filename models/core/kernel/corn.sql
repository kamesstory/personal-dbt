{{
  config(
    tags=["corn", "core"]
  )
}}

select 'corn' as plant

{{ override_config_for_census_test() }}