
{{ config(materialized='materialized_view') }}

SELECT EXTRACT(HOUR FROM started_at) AS start_time, 
	AVG(AGE(ended_at, started_at)) AS average_duration,
	AVG(EXTRACT(EPOCH FROM (ended_at - started_at))) AS average_duration_epochs
 FROM {{ ref('bike_log')}}
	GROUP BY start_time
	ORDER BY start_time
