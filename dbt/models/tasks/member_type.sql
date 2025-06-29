{{ config(materialized='table') }}

WITH member_id AS (
  SELECT ROW_NUMBER() OVER (ORDER BY member_casual) AS member_id,
  member_casual AS member_type
  FROM citibike
  GROUP BY member_type
)

SELECT * FROM member_id
