

{{ config(materialized='table') }}

WITH rideable_type_with_id AS (
  SELECT ROW_NUMBER() OVER (ORDER BY rideable_type) AS rideable_type_id,
  rideable_type
  FROM citibike
  GROUP BY rideable_type
)

SELECT * FROM rideable_type_with_id
