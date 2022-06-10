-- We can get the config alias (if there is one) using config.get
-- If there's no alias, we need the model name

-- Need to find the config constructor so that this macro properly handles both
-- the inline .sql config() case and the usage inside another macro config.get()

{% macro override_config_for_census_test() %}

  {{ log("Overriding config for Census test with macro override_config_for_census_test...", true) }}

  {% set new_config = {'materialized': 'view', 'schema': 'census'} %}
  {{ return(builtins.config(new_config)) }}

{% endmacro %}
