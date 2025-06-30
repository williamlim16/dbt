

{{ config(materialized='materialized_view') }}

SELECT
    EXTRACT(YEAR FROM date_start) AS trip_year,
    EXTRACT(QUARTER FROM date_start) AS trip_quarter,
    sum(count) AS weekly_trip_volume
FROM
  {{ ref('trip_daily_counts')}}
GROUP BY
    trip_year, trip_quarter
ORDER BY
    trip_year, trip_quarter;
