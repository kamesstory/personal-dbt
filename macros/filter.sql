{% macro count_with_filter(column_name, condition) %}
count(case when {{ column_name }} = '{{ condition }}' then 1 end)
{% endmacro %}