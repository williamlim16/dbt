# Scripts
## Extract
Extraction script is located in scripts/extract.py. It does two things which are downloading the zip file and extract the zip file into a folder. 

## Load
Load the resulting csv file into the database which in this case is PostgreSQL. The script will itterate through all the csv files and use `COPY` command from PostgreSQL to ensure realibility. The script can be found in scripts/load.py

# Tasks
All of the requirements answers can be found in models/tasks/ which includes a few analytical queries and a fact table. 

# Visualization
Extra visualization is also included to get insight from the data which can be found in visualization folder. These visualization is achieved through `plotly` library. This particular library gives an interactive visualization so that the data is accessible by the user. The process can be found in `viz_builder.ipynb`.

# Justifications
## Star schema
Star schema is chosen for this project because of the nature of the data source table. It does not have a lot of columns and can be easily splitted into multiple dimensions. Not only it allows user to do more simple queries, but it also allows faster queries.


