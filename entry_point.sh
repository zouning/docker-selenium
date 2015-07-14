#!/bin/bash
#/tmp/splunk/bin/splunk edit user admin -password changed --accept-license --answer-yes --no-prompt -auth admin:changeme
#/tmp/splunk/bin/splunk start --accept-license --answer-yes --no-prompt
#export SPLUNK_HOME=/tmp/splunk
#$SPLUNK_HOME/bin/splunk start &
#touch $SPLUNK_HOME/etc/.ui_login

export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

#function shutdown {
#  kill -s SIGTERM $NODE_PID
#  wait $NODE_PID
#}

nohup /usr/sbin/sshd -D &
x11vnc -display :20 -forever -usepw -create &
# We just need the desktop. no need selenium.
#xvfb-run --server-args="$DISPLAY -screen 0 $GEOMETRY -ac +extension RANDR"  \
#   tail -f /dev/null &
 # java -jar /opt/selenium/selenium-server-standalone.jar &
#NODE_PID=$!

#mkdir -p /opt/git_projects
#cd /opt/git_projects
git config --global user.email "nzou@splunk.com"
git config --global user.name "Ning Zou"
#git clone https://zouning:Openview1@github.com/zouning/docker-selenium.git

#trap shutdown SIGTERM SIGINT
#wait $NODE_PID
tail -f /dev/null


