#!/bin/bash
# su instead of sudo to get HOME dir changed to vagrant user 

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

# ----------------------
clone_repos
source $APP_DIR/resources/.env.bash
sudo $APP_DIR/install-server.sh
wp_prepare $GITHUB_TOKEN
run_tests
