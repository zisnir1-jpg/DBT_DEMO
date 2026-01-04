{{ config(materialized='table') }}

with trips as 
(
    select ride_id
        ,rideable_type
        ,date(to_timestamp(start_at)) as trip_date
        ,start_station_id 
        ,END_STATION_ID
        ,member_casual
        ,timestampdiff(second, to_timestamp(start_at), to_timestamp(END_AT)) as trip_duration_seconds
    from {{ source('demo', 'bike') }}
    where start_at <> 'started_at'
)

select *
from trips