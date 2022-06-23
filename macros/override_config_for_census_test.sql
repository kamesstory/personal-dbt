-- We can get the config alias (if there is one) using config.get
-- If there's no alias, we need the model name (coalesce using python's or)

{% macro override_config_for_census_test() %}

  {{ log("Overrode config for Census test on model: " ~ model['original_file_path'], true) }}

  {% set underscored_name = model['unique_id'].replace('.', '_') %}
  {% set unique_model_name = '_'.join(['checks', 'manual_test', underscored_name]).lower() %}
  {% set new_config = {'materialized': 'view', 'schema': 'census', 'alias': unique_model_name} %}

  {{ return(builtins.config(new_config)) }}

{% endmacro %}
