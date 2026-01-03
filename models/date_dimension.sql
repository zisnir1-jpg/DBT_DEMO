with cte as 
(
    select to_timestamp(START_AT) as started_at
        ,date(started_at) as date_started_at
        ,hour(started_at) as hour_started_at
        ,case when dayname(started_at) in ('Sat', 'Sun') then 'WEEKEND'
            ELSE 'BUSINESSDAY' END AS DAY_TYPE
        ,CASE WHEN MONTH(started_at)  IN (12,1,2) THEN 'WINTER'
            WHEN MONTH(started_at) IN (3,4,5) THEN 'SPRING'
            WHEN MONTH(started_at) IN (6,7,8) THEN 'SUMMER'
            ELSE 'AUTUMN' END AS STATION_OF_YEAR
    from {{ source('demo', 'bike') }}
    where START_AT <> 'started_at'
)

select *
from cte