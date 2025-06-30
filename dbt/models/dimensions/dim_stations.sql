{{ config(materialized='table') }}

WITH stations AS (
  SELECT start_station_id as station_id, start_station_name as station_name 
  FROM {{ ref("start_stations")}}

  UNION ALL

  SELECT end_station_id as station_id, end_station_name as station_name
  FROM {{ ref("end_stations")}}
  WHERE NOT EXISTS ( SELECT * FROM {{ ref("start_stations")}} )
)


SELECT * FROM stations
