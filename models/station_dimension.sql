{{ config(materialized='table') }}

with bike as 
(
    select distinct 
         start_station_id  as station_id
        ,start_station_name as station_name
        ,start_lat
        ,start_lng
    from {{ ref('stg_bike') }}
    where started_at <> 'started_at'
)
 
select *
from bike