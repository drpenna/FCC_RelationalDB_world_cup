#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE games, teams RESTART IDENTITY")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

#ignores first line in games.csv
  if [[ $YEAR != "year" ]]

  then

# ADD WINNERS NAMES TO TEAMS TABLE #####################################

  #get winner_name (should return empty table)
  WINNER_NAME=$($PSQL "SELECT DISTINCT(name) FROM teams WHERE name='$WINNER';")

  #if not found (-z tests if above query came empty)
    if [[ -z $WINNER_NAME ]]
    then

    #insert winner_id
    INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
      : '
      if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
      then
      echo "Inserted into teams(name), $WINNER"
      else 
      echo "Something went wrong?"
      fi
      '
    
        

    #get new winner_name (to show table is filled)
    WINNER_NAME=$($PSQL "SELECT DISTINCT(name) FROM teams WHERE name='$WINNER';")
    fi

#ADD OPPONENT NAMES TO TEAMS TABLE ##################################

#get opponent_name (should return empty table)
  OPPONENT_NAME=$($PSQL "SELECT DISTINCT(name) FROM teams WHERE name='$OPPONENT';")

  #if not found (-z tests if above query came empty)
    if [[ -z $OPPONENT_NAME ]]
    then

    #insert opponent_id
    INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
      : '
      if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
      then
      echo "Inserted into teams(name), $OPPONENT"
      else 
      echo "Something went wrong?"
      fi
      '
        

    #get new opponent_name (to show table is filled)
    OPPONENT_NAME=$($PSQL "SELECT DISTINCT(name) FROM teams WHERE name='$OPPONENT';")
    fi



  fi
done


cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

#ignores first line in games.csv
  if [[ $YEAR != "year" ]]

  then


# ADD DATA TO GAMES TABLE #####################################

  #get game_data (should return empty table)
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")

  GAME_DATA=$($PSQL "SELECT year, round, winner_id, opponent_id, winner_goals, opponent_goals
   FROM games WHERE year='$YEAR' AND round='$ROUND' AND winner_id='$WINNER_ID' 
   AND opponent_id='$OPPONENT_ID' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS';")

  #if not found (-z tests if above query came empty)
    if [[ -z $GAME_DATA ]]
    then

    #insert game_data
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
    VALUES('$YEAR', '$ROUND', '$WINNER_ID', '$OPPONENT_ID', '$WINNER_GOALS', '$OPPONENT_GOALS');")
    : ' if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
      then
      echo "Inserted into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals), $WINNER, $ROUND, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS "
      else 
      echo "Something went wrong?"
      fi
      '
        

    #get new game_data (to show table is filled)
    GAME_DATA=$($PSQL "SELECT year, round, winner_id, opponent_id, winner_goals, opponent_goals
   FROM games WHERE year='$YEAR' AND round='$ROUND' AND winner_id='$WINNER_ID' 
   AND opponent_id='$OPPONENT_ID' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS';")
    fi

fi
done
