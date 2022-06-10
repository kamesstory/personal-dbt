-- We can get the config alias (if there is one) using config.get
-- If there's no alias, we need the model name (coalesce using python's or)

{% macro override_config_for_census_test() %}

  {{ log("Overriding config for Census test with macro override_config_for_census_test...", true) }}

  {{ log("Model currently is " ~ model, true) }}

  {{ log("Model fqn is " ~ model['fqn'], true) }}

  {% set joined_fqn = '.'.join(model['fqn']) %}
  {% set overriding_name = joined_fqn ~ '_123456' %}

  {% set new_config = {'materialized': 'view', 'schema': 'census', 'alias': overriding_name} %}
  {{ return(builtins.config(new_config)) }}

{% endmacro %}
