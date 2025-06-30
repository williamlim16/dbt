{{ config(materialized='materialized_view') }}

SELECT EXTRACT(WEEK FROM date_start) AS trip_week, EXTRACT(YEAR FROM date_start) AS trip_year, sum(count) 
	FROM {{ ref('trip_daily_counts')}}
GROUP BY trip_week, trip_year
ORDER BY trip_year, trip_week

