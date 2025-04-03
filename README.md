# Instructions

This project is structured to provide practice and homework with SQL and MongoDB queries. Below is a detailed
explanation of the directory structure and functionalities:

## Directory Structure

- **MySQL/**
  - `SQL_Practice/`: Contains SQL files for practicing SQL commands and queries.
  - `Homeworks/`: Contains SQL files for completing SQL homework tasks.

- **MongoDB/**
  - `Practice/`: Contains files related to MongoDB practice tasks.
  - `Homework/`: Contains files related to MongoDB homework tasks.
  - `main.py`: A Python script that allows you to run MongoDB queries. You can execute a specific query and view the
    results both in the terminal and saved in a `result.json` file.
  - `db_connect.py`: This file is responsible for connecting to MongoDB on two servers, `ich1` and `ich_editor`.

## Running Queries

You can execute MongoDB queries using the `main.py` script. Use the following command to run a query by its name:

```bash
python main.py <query_name>
```

Replace `<query_name>` with the actual name of the query you want to run.

### Output

- The query result will be displayed in the console.
- The query result will also be saved into a file named `result.json`.

## Dependencies

Before running any scripts, ensure all necessary dependencies are installed. Run the following command to install the
required packages:

```bash
pip install -r requirements.txt
```

Now, you are all set to carry out SQL and MongoDB practice and homework tasks.

