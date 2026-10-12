#!/usr/bin/env bash
# Usage: bash show_cases.sh 4   -> runs TC4 only (both modes)
#        bash show_cases.sh     -> runs all test cases
TC=${1:-0}
CLASS="Sanjith_Thread"
javac "$CLASS.java" || { echo "Compile failed"; exit 1; }
cases=("1 1 1000" "2 2 10000" "3 5 10000" "4 10 50000" "5 20 50000" "6 50 50000" "7 100 50000")
for c in "${cases[@]}"; do
  set -- $c
  [ "$TC" -ne 0 ] && [ "$1" -ne "$TC" ] && continue
  for mode in true false; do
    echo; echo "===== TC$1: java $CLASS $2 $3 $mode ====="
    java $CLASS $2 $3 $mode
  done
done
