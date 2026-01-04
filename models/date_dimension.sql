{{ config(materialized='table') }}

with cte as 
(
    select to_timestamp(started_at) as started_at
        ,date(to_timestamp(started_at)) as date_started_at
        ,hour(to_timestamp(started_at)) as hour_started_at
        ,case when dayname(to_timestamp(started_at)) in ('Sat', 'Sun') then 'WEEKNED'
            else 'BUSINESSDAY' end as day_type
        ,case when MONTH(to_timestamp(started_at)) IN (12,1,2) THEN 'WINTER'
            WHEN MONTH(to_timestamp(started_at)) IN (3,4,5) THEN 'SPRING'
            WHEN MONTH(to_timestamp(started_at)) IN (6,7,8) THEN 'SUMMER'
            ELSE 'AUTUMN' END AS STATION_OF_YEAR
    from {{ ref('stg_bike') }}
    where started_at <> 'started_at'
)

 
select *
from cte