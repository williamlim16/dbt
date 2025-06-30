
{{ config(materialized='table') }}

WITH end_station_id AS (
  SELECT DISTINCT end_station_id, end_station_name
  FROM citibike
  WHERE end_station_id IS NOT NULL
)

SELECT * FROM end_station_id
