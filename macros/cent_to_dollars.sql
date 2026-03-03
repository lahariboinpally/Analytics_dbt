{# A basic example for a project-wide macro to cast a column uniformly #}
{% macro cents_to_dollars(column_name) -%}
    {{ return(adapter.dispatch("cents_to_dollars")(column_name)) }}
{%- endmacro %}

{% macro default__cents_to_dollars(column_name) -%}
    coalesce(({{ column_name }} / 100)::numeric(16, 2), 0)
{%- endmacro %}