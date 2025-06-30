

{{ config(materialized='materialized_view') }}

SELECT date_trunc('day', started_at) AS date_start,count(*) FROM {{ref('bike_log')}}
GROUP BY date_start
ORDER BY date_start
