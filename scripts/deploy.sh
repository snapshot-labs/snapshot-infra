#!/bin/bash

dist_folder=$1

if [ -z "$dist_folder" ]; then
  dist_folder="../snapshot-infra-services"
fi

envelop_ui_repo="git@github.com:snapshot-labs/envelop-ui.git"
envelop_repo="git@github.com:snapshot-labs/envelop.git"
keycard_repo="git@github.com:snapshot-labs/keycard.git"
score_api_repo="git@github.com:snapshot-labs/score-api.git"
snapshot_hub_repo="git@github.com:snapshot-labs/snapshot-hub.git"
snapshot_relayer_repo="git@github.com:snapshot-labs/snapshot-relayer.git"
snapshot_sequencer_repo="git@github.com:snapshot-labs/snapshot-sequencer.git"
snapshot_repo="git@github.com:snapshot-labs/snapshot.git"
snapshot_sidekick_repo="git@github.com:snapshot-labs/snapshot-sidekick.git"
brovider_repo="git@github.com:snapshot-labs/brovider.git"
pineapple_repo="git@github.com:snapshot-labs/pineapple.git"

# function that copies files from current repo to dist folder
add_envs_files() {
  local dist_path="$1"
  local repo_name="$2"

  if [ ! -f "$dist_path/.env" ]; then
    if [ -f "$dist_path/.env.example" ]; then
      cp $dist_path/.env.example $dist_path/.env
    else
      touch $dist_path/.env
    fi
  fi
}

clone_repo() {
  local repo="$1"
  local env_name="$2"

  repo_name=$(echo $repo | sed 's/.*\/\(.*\)\.git/\1/')

  dist_path="$dist_folder/$repo_name"

  if [ ! -d "$dist_path" ]; then
    git clone $repo $dist_path
    cd $dist_path
    git submodule update --init --recursive
    cd -
  fi

  sed -i "" "s|${env_name}=.*|${env_name}=${dist_path}|g" .env

  add_envs_files $dist_path $repo_name
}

clone_repo $envelop_ui_repo "ENVELOP_UI_REPO_PATH"
clone_repo $envelop_repo "ENVELOP_REPO_PATH"
clone_repo $keycard_repo "KEYCARD_REPO_PATH"
clone_repo $score_api_repo "SCORE_API_REPO_PATH"
clone_repo $snapshot_hub_repo "SNAPSHOT_HUB_REPO_PATH"
clone_repo $snapshot_relayer_repo "SNAPSHOT_RELAYER_REPO_PATH"
clone_repo $snapshot_sequencer_repo "SNAPSHOT_SEQUENCER_REPO_PATH"
clone_repo $snapshot_repo "SNAPSHOT_REPO_PATH"
clone_repo $snapshot_sidekick_repo "SNAPSHOT_SIDEKICK_REPO_PATH"
clone_repo $brovider_repo "BROVIDER_REPO_PATH"
clone_repo $pineapple_repo "PINEAPPLE_REPO_PATH"
