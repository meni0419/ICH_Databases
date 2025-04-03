# Instructions

This project is structured to provide practice and homework with SQL and MongoDB queries. Below is a detailed
explanation of the directory structure and functionalities:

## Directory Structure

- **MySQL/**
  - `SQL_Practice/` - Contains SQL files for practicing SQL commands and queries.
  - `Homeworks/` - Contains SQL files for completing SQL homework tasks.

- **MongoDB/**
  - `Practice/` - Contains files related to MongoDB practice tasks.
  - `Homework/` - Contains files related to MongoDB homework tasks.

- **Scripts:**
  - `main.py` - A Python script to execute MongoDB queries. You can run a specific query and view the results both in
    the terminal and saved in a `result.json` file.
  - `db_connect.py` - Handles connections to MongoDB on two servers: `ich1` and `ich_editor`.

- **Environment Variables (.env):**
  - `ICH1_USERNAME=`
  - `ICH1_PASSWORD=`
  - `ICH_EDITOR_USERNAME=`
  - `ICH_EDITOR_PASSWORD=`
  - `MONGO_HOST=`
  - `MONGO_PORT=`

## Running Queries

You can execute MongoDB queries using the `main.py` script. Use the following command to run a query by its name:

```bash
python main.py <query_name>
```

Replace `<query_name>` with the actual name of the query you want to run for example

```bash
python main.py hw1_task1
```

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

