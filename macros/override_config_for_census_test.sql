-- We can get the config alias (if there is one) using config.get
-- If there's no alias, we need the model name (coalesce using python's or)

{% macro override_config_for_census_test() %}

  {{ log("Overriding config for Census test with macro override_config_for_census_test...", true) }}
  {{ log("Model:" ~ model, true) }}

  {% set model_name = model['name'] %}
  {{ log("Model name:" ~ model_name, true) }}

  {% set existing_name = builtins.config.get('alias') or model_name %}

  {{ log("Existing name = " ~ existing_name, true) }}

  {% set alias = existing_name ~ '_123456' %}

  {{ log("New alias = " ~ alias, true)}}

  {% set new_config = {'materialized': 'view', 'schema': 'census', 'alias': alias} %}
  {{ return(builtins.config(new_config)) }}

{% endmacro %}
