#!/bin/bash

# read and set environment variables
set -a
source .env
set +a

database_relayer="snapshot-relayer"
database_sequencer="snapshot-sequencer"
database_keycard="keycard"
database_envelop="envelop"

database_relayer_schema="$SNAPSHOT_RELAYER_REPO_PATH/src/schema.sql"
database_sequencer_schema="$SNAPSHOT_SEQUENCER_REPO_PATH/src/helpers/schema.sql"
database_keycard_schema="$KEYCARD_REPO_PATH/src/helpers/schema.sql"
database_envelop_schema="$ENVELOP_REPO_PATH/src/helpers/schema.sql"

dist_path="./schemas"

transform_sql_file() {
  local database_relayer="$1"
  local database_relayer_schema="$2"

  local temp_file="$(mktemp)"

  printf "CREATE DATABASE IF NOT EXISTS \`$database_relayer\`;\n" | cat - "$database_relayer_schema" > "$temp_file"

  sed "s/CREATE TABLE /CREATE TABLE \`$database_relayer\`./g" "$temp_file" > "$dist_path/$database_relayer.sql"
}

transform_sql_file $database_relayer $database_relayer_schema
transform_sql_file $database_sequencer $database_sequencer_schema
transform_sql_file $database_keycard $database_keycard_schema
transform_sql_file $database_envelop $database_envelop_schema

