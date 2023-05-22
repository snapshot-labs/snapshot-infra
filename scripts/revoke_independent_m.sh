#!/bin/bash

dist_folder=$1

if [ -z "$dist_folder" ]; then
  echo "Please provide path to the repositorie's folder"
  exit 1
fi

remove_file() {
  local file_path="$1"
  local file_name="$2"

  exclude_file=$file_path/.git/info/exclude

  if grep -q "^$file_name$" "$exclude_file"; then
    # The file name is in the exclude file, remove it
    sed -i "" "/^$file_name$/d" "$exclude_file"
    rm "$file_path/$file_name"
  fi
}

remove_file $dist_folder ".dockerignore"
remove_file $dist_folder "Dockerfile"
