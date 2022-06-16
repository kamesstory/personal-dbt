{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        overriden_{{ default_schema }}

    {%- else -%}

        overriden_{{ custom_schema_name }}

    {%- endif -%}

{%- endmacro %}