-- We can get the config alias (if there is one) using config.get
-- If there's no alias, we need the model name

-- Need to find the config constructor so that this macro properly handles both
-- the inline .sql config() case and the usage inside another macro config.get()

{% macro override_config_for_census_test() %}

  {{ log("Running macro config()...", true) }}
  {{ log("Kwargs:", true) }}
  {{ log(kwargs, true) }}

  {% set _dummy = kwargs.update({'materialized': 'view', 'schema': 'test'}) %}
  {{ log(kwargs, true) }}
  {{ return(builtins.config(kwargs)) }}

{% endmacro %}
