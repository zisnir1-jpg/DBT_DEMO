{% macro get_season(x) %}

    CASE WHEN MONTH(to_timestamp({{x}}))  IN (12,1,2) THEN 'WINTER'
    WHEN MONTH(to_timestamp({{x}})) IN (3,4,5) THEN 'SPRING'
    WHEN MONTH(to_timestamp({{x}})) IN (6,7,8) THEN 'SUMMER'
    ELSE 'AUTUMN' END

{% endmacro%}

{% macro day_type(x) %}

case when dayname((to_timestamp({{x}}))) in ('Sat', 'Sun') then 'WEEKEND'
    ELSE 'BUSINESSDAY' END
{% endmacro%}