
{{ config(materialized='table') }}

WITH start_station_id AS (
  SELECT DISTINCT start_station_id, start_station_name
  FROM citibike
  WHERE start_station_id IS NOT NULL
)


SELECT * FROM start_station_id
