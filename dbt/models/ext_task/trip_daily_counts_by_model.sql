
{{ config(materialized='materialized_view') }}

SELECT date_trunc('day', started_at) AS date_start,rt.rideable_type AS rideable_type ,count(*) 
FROM {{ref('fct_bike_log')}} bl
JOIN {{ ref('dim_rideable_type')}} rt
ON bl.rideable_type_id = rt.rideable_type_id
GROUP BY date_start, rideable_type
ORDER BY date_start
