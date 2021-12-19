#!/bin/bash -e
#
# Run this script to generate wav files in GLaDOS' voice based on the lines in the input csv.
# Existing files are not overwritten. Requires curl.

inputfile=$1 # The input csv file.
outputdir=output/speech # The output directory.

mkdir -p $outputdir

while IFS=, read -r name quotedtext; do
  text="${quotedtext%\"}"
  text="${text#\"}"

  filename="$outputdir/$name"

  echo "Processing: $text"
  if [ ! -f "$filename" ]; then
    curl -Ls --retry 30 --get --fail \
      --data-urlencode "text=$text" \
      -o "$filename" \
      'https://glados.c-net.org/generate'
  fi
done < $inputfile
