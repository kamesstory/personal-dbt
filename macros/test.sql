-- We can get the config alias (if there is one) using config.get
-- If there's no alias, we need the model name

{% macro config() %}

  {{ log("Running macro config()...", true) }}
  {{ log("Kwargs:", true) }}
  {{ log(kwargs, true) }}

  {% set _dummy = kwargs.update({'materialized': 'view', 'schema': 'test'}) %}
  {{ log(kwargs, true) }}
  {% do return(builtins.config(kwargs)) %}

{% endmacro %}
