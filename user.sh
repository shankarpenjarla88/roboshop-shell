#!/bin/bash

date=$(date +%F)
scriptname=$0
logfile=/tmp/$scriptname-$date.log

R="\e[31m"
G="\e[32m"
N="\e[0m"

validate() {
    if [ $1 -ne 0 ]
    then 
      echo -e "$2 IS  $R FAILED $N"
    else
      echo -e "$2 IS $G SUCCESS $N"
    fi
}

userid=$( id -u )

if [ $userid -ne 0 ]
then 
  echo "ERROR:PLEASE LOGIN TO ADMIN ACCESS"
  exit 1
else
  echo "NOW YOU ARE IN THE ROOT ACCESS"
fi


curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y

useradd roboshop

mkdir /app

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip

cd /app 

unzip /tmp/user.zip

cd /app 

npm install 

cp /root/shell-scripts/roboshop-shell/user.service /etc/systemd/system/user.service

systemctl daemon-reload

systemctl enable user 

systemctl start user

cp /root/shell-scripts/roboshop-shell/mongo.repo  /etc/yum.repos.d/mongo.repo

yum install mongodb-org-shell -y

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js