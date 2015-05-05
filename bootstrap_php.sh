#!/bin/bash

GITHUB_TOKEN=$1
export GITHUB_USER=$2 || amarcinkowski
echo "=============== $GITHUB_USER"
export APP_DIR=/var/www
export REPO_DIR=/home/vagrant/repo
export SCRIPTS_DIR=$APP_DIR/scripts
github_projects=(hospitalpage hospitalplugin hospitaltheme punction epidemio)

source /vagrant/functions.sh

#vagrant prepare
#wp prepare
function wp_prepare {
  $SCRIPTS_DIR/install-wp-cli.sh
  $SCRIPTS_DIR/install-dependencies.sh $1
  $SCRIPTS_DIR/install-wp-all.sh
  $SCRIPTS_DIR/install-db.sh
}

#run tests
function run_tests {
  $SCRIPTS_DIR/install-wp-tests.sh
  cd $APP_DIR
  phpunit -c phpunit-wpdb.xml
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
echo "PROJECTS: ${github_projects[@]}"
clone_repos ${github_projects[@]}
source $APP_DIR/resources/.env.bash
sudo apt-get update
sudo $SCRIPTS_DIR/install-server.sh
wp_prepare $GITHUB_TOKEN
link_projects 
run_tests
