import psycopg2
import pandas as pd

conn = psycopg2.connect(
    database="dbt-demo",
    user="postgres",
    password="postgres",
    host="localhost",
    port="5432",
)
cur = conn.cursor()

query = "SELECT date_start, count FROM staging.trip_daily_counts"
cur.execute(query)

data = cur.fetchall()
columns = pd.Series(["date_start", "count"])
df = pd.DataFrame(data, columns=columns)
print(df)

cur.close()
conn.close()
