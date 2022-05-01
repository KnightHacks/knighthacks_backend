#!/bin/bash
folders=("users" "sponsors" "hackathon" "events")

for folder in "${folders[@]}"
do
   :
   printf "Regenerating %s schema\n" "$folder"
   cd "./knighthacks_$folder" || exit
   bash generate.sh
   cd ..
done

exit