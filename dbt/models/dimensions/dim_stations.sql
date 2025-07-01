{{ config(materialized='table') }}

WITH all_stations AS (
  SELECT
    start_station_id AS station_id,
    start_station_name AS station_name
  FROM {{ ref("start_stations") }}

  UNION ALL -- Use UNION ALL to avoid a costly deduplication step if you plan to group later

  SELECT
    end_station_id AS station_id,
    end_station_name AS station_name
  FROM {{ ref("end_stations") }}
),

cleaned_stations AS (
  SELECT
    station_id,
    -- You can choose MIN, MAX, or a more sophisticated aggregation here
    MIN(station_name) AS station_name
  FROM all_stations
  GROUP BY 1 -- Group by station_id
)

SELECT * FROM cleaned_stations
