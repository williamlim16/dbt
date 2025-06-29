
{{ config(materialized='materialized_view') }}


SELECT day_of_week,
       start_station_id,
	   number_of_starts
FROM (
                select   to_char(started_at, 'Day') AS day_of_week, EXTRACT(DOW FROM started_at) AS dow_number,
                         start_station_id,
                         count(*)                                                                           AS number_of_starts,
                         row_number() OVER (partition BY to_char(started_at, 'Day') ORDER BY count(*) DESC) AS rn
                FROM     {{ ref('bike_log')}}
                GROUP BY to_char(started_at, 'Day'), dow_number,
                         start_station_id) as ranked_stations
WHERE rn = 1
ORDER BY dow_number
