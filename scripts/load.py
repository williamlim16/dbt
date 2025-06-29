import psycopg2
import os

script_dir = os.path.dirname(os.path.abspath(__file__))

local_data_path = os.path.join("data")

server_base_path = "/Users/williamlim/dev/canstar/data"

conn = psycopg2.connect("dbname=dbt-demo user=postgres password=postgres")
cur = conn.cursor()

try:
    cur.execute(
        """
        CREATE TABLE IF NOT EXISTS citibike (
        ride_id text PRIMARY KEY,
        rideable_type text ,
        started_at timestamp,
        ended_at timestamp,
        start_station_name text,
        start_station_id text,
        end_station_name text,
        end_station_id text,
        start_lat float,
        start_lng float,
        end_lat float,
        end_lng float,
        member_casual text
        );
        """
    )
    conn.commit()
    print("Table 'citibike' created successfully (if it didn't exist).")

    # List directories based on your local data structure to construct server paths
    # Note: This assumes the directory structure (e.g., '2023-citibike-tripdata')
    # is identical on both the local machine and the PostgreSQL server under server_base_path.
    data_folders = os.listdir(
        local_data_path
    )  # Use local_data_path to iterate through folders
    for folder in data_folders:
        # Construct the full path to the folder on the LOCAL machine to check if it's a directory
        local_folder_path = os.path.join(local_data_path, folder)

        if os.path.isdir(local_folder_path):  # Check if it's a directory locally
            print(f"Processing folder: {folder}")
            # List files within the folder on the LOCAL machine
            files = os.listdir(local_folder_path)  # Use local_folder_path here

            for file in files:
                if file.lower().endswith(".csv"):
                    # Construct the absolute path to the file *on the PostgreSQL server*
                    server_file_full_path = os.path.join(server_base_path, folder, file)

                    print(
                        f"Instructing PostgreSQL to COPY from server file: {server_file_full_path}"
                    )
                    try:
                        cur.execute(
                            f"""
                            COPY citibike(ride_id,
                            rideable_type,
                            started_at,
                            ended_at,
                            start_station_name,
                            start_station_id,
                            end_station_name,
                            end_station_id,
                            start_lat, start_lng, end_lat, end_lng, member_casual) FROM '{server_file_full_path}' WITH HEADER CSV
                            """
                        )
                        conn.commit()
                        print(f"Successfully copied data from {file}")
                    except psycopg2.Error as e:
                        conn.rollback()  # Always rollback on error
                        print(f"Error copying data from {file}: {e}")
                        # You might want to break or continue to the next file depending on your needs
                else:
                    print(f"Skipping non-CSV file: {file} in folder {folder}")
        else:
            print(f"Skipping non-directory item: {folder} in {local_data_path}")

except psycopg2.Error as e:
    conn.rollback()
    print(f"A general database error occurred: {e}")

finally:
    if cur:
        cur.close()
    if conn:
        conn.close()
