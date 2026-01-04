{{ config(materialized='table') }}

with trips as 
(
    select ride_id
       -- ,rideable_type
        ,date(to_timestamp(started_at)) as trip_date
        ,start_station_id 
        ,END_STATION_ID
        ,member_casual
        ,timestampdiff(second, to_timestamp(started_at), to_timestamp(ended_at)) as trip_duration_seconds
    from {{ ref('stg_bike') }}
    where started_at <> 'started_at'
)

select *
from trips