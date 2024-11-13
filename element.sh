#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else 
  GET_ELEM=$($PSQL "select elements.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements left join properties on elements.atomic_number=properties.atomic_number left join types using (type_id) where symbol='$1' or name='$1' or elements.atomic_number::text='$1';")
  if [[ -z $GET_ELEM ]]
  then
    echo I could not find that element in the database.
  else
    echo $GET_ELEM | while IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
fi

