# FCC_RelationalDB_world_cup

This is my solution for the [**Build a World Cup Database**](https://www.freecodecamp.org/learn/relational-database/build-a-world-cup-database-project/build-a-world-cup-database)
required project for the [**freeCodeCamp's Relational Databases Certification**](https://www.freecodecamp.org/learn/relational-database/) using PostgreSQL and bash. <br />

## Contents
- [Project Tasks Summary](#project-tasks-summary)
- [Files](#files)
  - [games.csv](#games.csv)
  - [worldcup.sql](#worldcup.sql)
      - [table *games*](#games)
      - [table *teams*](#teams)
  - [insert_data.sh](#insert_data.sh)
  - [queries.sh](#queries.sh)
  - [expected_output.txt](#expected_output.txt)
- [Project tasks](#project-tasks)

## Project Tasks Summary
The project required the completion of the following steps:
1. Creating a database ([worldcup.sql](#worldcup.sql)) with empty rows to receive the content from the [games.csv](#games.csv) file;
2. Creating a bash script ([insert_data.sh](#insert_data.sh)) to automatically insert all the content from [games.csv](#games.csv) into the appropriate tables in [worldcup.sql](#worldcup.sql);
3. Creating a bash script ([queries.sh](#queries.sh)) to query the database in a way that the output matches the [expected_output.txt](#expected_output.txt) file.

[<sub>Back to top</sub>](#top)

## Files

### games.csv

Initial file provided by freeCodeCamp.\
It contains a comma-separated list of all games of the final three rounds of the World Cup tournament since 2014; the titles are at the top. 
It includes the year of each game, the round of the game, the winner, their opponent, and the number of goals each team scored.

[<sub>Back to top</sub>](#top)

### worldcup.sql
The database can be rebuilt by entering `psql -U postgres < worldcup.sql` in a terminal where the `.sql` file is.\
The file in this repository is already filled with the contents from [games.csv](#games.csv), but during the project, they were empty as per below tables. 
The user can empty the rows in the tables of this database by inputting `TRUNCATE TABLE games, teams;` in the psql terminal.

[<sub>Back to top</sub>](#top)

#### games

|game_id <sup>1</sup>|	year <sup>2</sup>|	round <sup>3</sup>| winner_id <sup>4</sup>| opponent_id <sup>5</sup> | winner_goals <sup>6</sup> | opponent_goals <sup>7</sup> |	
|:------------------:|:-----------------:|:------------------:|:---------------------:|:------------------------:|:-------------------------:|:---------------------------:|
|                    |                   |                    |                       |                          |                           |                             |

<sup>1</sup> serial, primary key, not null\
<sup>2</sup> int, not null\
<sup>3</sup> varchar(20), not null\
<sup>4</sup> int, not null, foreign key REFERENCES teams(team_id)\
<sup>5</sup> int, not null, foreign key REFERENCES teams(team_id)\
<sup>6</sup> int, not null\
<sup>7</sup> int, not null

[<sub>Back to top</sub>](#top)

#### teams

|team_id <sup>8</sup>|	name <sup>9</sup>|	
|:------------------:|:-----------------:|
|                    |                   |

<sup>8</sup> serial, primary key, not null\
<sup>9</sup> varchar(20), not null, unique

[<sub>Back to top</sub>](#top)


### insert_data.sh
It can be started by inputting ./insert_data.sh in the terminal. \
It'll fill all the tables in [worldcup.sql](#worldcup.sql) automatically.\
The tests in the project had a 20 second limit, so the script had to be efficient.

[<sub>Back to top</sub>](#top)

### queries.sh
Script that can be started by inputting `./queries.sh` in the terminal. \
If [worldcup.sql](#worldcup.sql) was correctly filled with the content from [games.csv](#games.csv) by using [insert_data.sh](#insert_data.sh), 
starting `./queries.sh` should print texts matching the content in [expected_output.txt](#expected_output.txt) in the terminal.

[<sub>Back to top</sub>](#top)

### expected_output.txt
Initial file provided by freeCodeCamp with the expected output for [queries.sh](#queries.sh).

[<sub>Back to top</sub>](#top)

## Project Tests
The goal was to create a database in PostgreSQL and two scripts in bash that passed the following tests\
(more details available on [**Build a World Cup Database**](https://www.freecodecamp.org/learn/relational-database/build-a-world-cup-database-project/build-a-world-cup-database)):

- You should create a database named `worldcup`
- You should **connect to your worldcup database** and then create `teams` and `games` tables
- Your `teams` table should have a `team_id` column that is a type of `SERIAL` and is the primary key, and a `name` column that has to be `UNIQUE`
- Your `games` table should have a `game_id` column that is a type of `SERIAL` and is the primary key, a `year` column of type `INT`, and a `round` column of type `VARCHAR`
- Your `games` table should have `winner_id` and `opponent_id` foreign key columns that each reference `team_id` from the `teams` table
- Your `games` table should have `winner_goals` and `opponent_goals` columns that are type `INT`
- All of your columns should have the `NOT NULL` constraint
- Your two script (`.sh`) files should have executable permissions. Other tests involving these two files will fail until permissions are correct. When these permissions are enabled, the tests will take significantly longer to run
- When you run your `insert_data.sh` script, it should add each unique team to the `teams` table. There should be 24 rows
- When you run your `insert_data.sh` script, it should insert a row for each line in the `games.csv` file (other than the top line of the file). 
There should be 32 rows. Each row should have every column filled in with the appropriate info. Make sure to add the correct ID's from the teams table (you cannot hard-code the values)
- You should correctly complete the queries in the `queries.sh` file. Fill in each empty `echo` command to get the output of what is suggested with the command above it. 
Only use a single line like the first query. The output should match what is in the `expected_output.txt` file **exactly**, take note of the number of decimal places in some of the query results

[<sub>Back to top</sub>](#top)
