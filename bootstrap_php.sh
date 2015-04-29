#!/bin/bash

export APP_DIR=/var/www
export REPO_DIR=/home/vagrant/repo
github_projects=(hospitalpage hospitalplugin hospitaltheme punction epidemio)
GITHUB_TOKEN=$1

#vagrant prepare
function clone_repos {
  sudo rm -rf $APP_DIR $REPO_DIR/*
  sudo apt-get -y install git
  for i in "${github_projects[@]}"
  do
    echo "PROJECT $i"
    git clone https://github.com/amarcinkowski/$i $REPO_DIR/$i
  done
  sudo rm -rf $APP_DIR
  sudo ln -s $REPO_DIR/hospitalpage $APP_DIR
}

#wp prepare
function wp_prepare {
  $APP_DIR/install-wp-cli.sh
  $APP_DIR/install-dependencies.sh $1
  $APP_DIR/install-wp-all.sh
  $APP_DIR/install-db.sh
}

#run tests
function run_tests {
  $APP_DIR/install-wp-tests.sh
  cd $APP_DIR
  phpunit -c phpunit-wpdb.xml
}

function replace_lib_with_git {
  rm -rf $1
  ln -s ~/repo/$2 $1
}

function link_projects {
  HP=/var/www/vendor/amarcinkowski/hospitalplugin
  HT=/var/www/wp-content/themes/responsive-child
  P=/var/www/wp-content/plugins/punction
  E=/var/www/wp-content/plugins/epidemio
  replace_lib_with_git $HP hospitalplugin
  replace_lib_with_git $HT hospitaltheme
  replace_lib_with_git $P punction
  replace_lib_with_git $E epidemio
}

# ----------------------
clone_repos
source $APP_DIR/resources/.env.bash
sudo apt-get update
sudo $APP_DIR/install-server.sh
wp_prepare $GITHUB_TOKEN
link_projects
run_tests
