{{ config(materialized='table') }}

WITH bike_log AS (
  SELECT ride_id as id, started_at, ended_at, start_station_id, end_station_id, rideable_type, start_lat, start_lng, end_lat, end_lng,
  member_casual
  FROM citibike
)

SELECT bl.id AS id,started_at, ended_at, rt.rideable_type_id, start_station_id, end_station_id,
start_lat, start_lng, end_lat, end_lng, mt.member_id
FROM bike_log bl
JOIN {{ ref('dim_rideable_type')}} rt
ON bl.rideable_type = rt.rideable_type
JOIN {{ ref('dim_member_type')}} mt
ON bl.member_casual = mt.member_type

