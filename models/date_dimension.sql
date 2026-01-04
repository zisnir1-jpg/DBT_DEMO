{{ config(materialized='table') }}
with cte as 
(
    select to_timestamp(START_AT) as started_at
        ,date(started_at) as date_started_at
        ,hour(started_at) as hour_started_at
        , {{day_type('start_at')}} as day_type --macro
        , {{get_season('start_at')}} as season --using macros from date_utils.sql
    from {{ source('demo', 'bike') }}
    where START_AT <> 'started_at'
)

select *
from cte