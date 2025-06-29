import requests
import zipfile
import io
import os
import glob

zip_url = "https://s3.amazonaws.com/tripdata/2023-citibike-tripdata.zip"

extraction_path = "./data2"


def download_data():
    print(f"Attempting to download from: {zip_url}")
    print(f"Extraction path set to: {os.path.abspath(extraction_path)}")

    try:
        response = requests.get(zip_url)
        response.raise_for_status()

        print("Download successful. Starting extraction...")

        with zipfile.ZipFile(io.BytesIO(response.content)) as z:
            z.extractall(extraction_path)
            print(
                f"Successfully extracted files to: {os.path.abspath(extraction_path)}"
            )

            print("\nExtracted files:")
            for filename in os.listdir(extraction_path):
                print(f"- {filename}")

    except requests.exceptions.RequestException as e:
        print(f"Error during download: {e}")
    except zipfile.BadZipFile:
        print("Error: The downloaded file is not a valid ZIP file.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")


os.makedirs(extraction_path, exist_ok=True)


def extract_zip():
    paths = os.listdir(extraction_path)
    for path in paths:
        print(f"Extracting each period.. {path}")
        zip_paths = glob.glob(f"{extraction_path}/{path}/*.zip")
        for zip_path in zip_paths:
            with zipfile.ZipFile(zip_path, "r") as z:
                z.extractall(f"{extraction_path}/{path}")
                print(
                    f"Successfully extracted files to: {os.path.abspath(extraction_path)}"
                )
            os.remove(zip_path)


if os.listdir(extraction_path):
    extract_zip()

else:
    download_data()
    extract_zip()
