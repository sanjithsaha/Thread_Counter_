#!/usr/bin/env bash
# Run:  bash run_all.sh
CLASS="Sanjith_Thread"
javac "$CLASS.java" || { echo "Compile failed"; exit 1; }
mkdir -p outputs
declare -A inc=( [1]=1000 [2]=10000 [5]=10000 [10]=50000 [20]=50000 [50]=50000 [100]=50000 )
res="outputs/results.csv"
echo "threads,increments,mode,run,expected,static,nonstatic,absdiff,pct" > "$res"
val() { echo "$1" | grep -F "$2" | head -1 | cut -d: -f2 | xargs; }
for n in 1 2 5 10 20 50 100; do
  m=${inc[$n]}
  for r in "true 1" "false 1" "false 2" "false 3" "false 4" "false 5"; do
    set -- $r; mode=$1; run=$2
    echo "Threads=$n Increments=$m Mode=$mode Run=$run"
    out=$(java $CLASS $n $m $mode)
    echo "$out" > "outputs/T${n}_${mode}_run${run}.txt"
    echo "$n,$m,$mode,$run,$(val "$out" "Expected count"),$(val "$out" "Static count"),$(val "$out" "Non-static total"),$(val "$out" "Absolute diff"),$(val "$out" "Difference")" >> "$res"
  done
done
echo "Done. See outputs/results.csv"
