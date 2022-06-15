-- We can get the config alias (if there is one) using config.get
-- If there's no alias, we need the model name (coalesce using python's or)

{% macro override_config_for_census_test() %}

  {{ log("Overriding config for Census test with macro override_config_for_census_test...", true) }}

  {% set joined_fqn = '.'.join(['checks', '13579'] + model['fqn']).lower() %}
  {% set new_config = {'materialized': 'view', 'schema': 'census', 'alias': joined_fqn} %}

  {{ return(builtins.config(new_config)) }}

{% endmacro %}
