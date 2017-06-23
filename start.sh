#!/bin/bash
LOG_FILE=~/jenkins.log
JENKINS_RUN="java -jar /opt/jenkins/bin/jenkins.war" 
exec 1>>${LOG_FILE}
exec 2>>${LOG_FILE}
nohup $JENKINS_RUN >> $LOG_FILE &

