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

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$logfile

validate $? "setting up NPM source"

yum install nodejs -y &>>$logfile

validate $? "NODEJS INSTALLATION"

useradd roboshop &>>$logfile



mkdir /app &>>$logfile


curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>>$logfile

validate $? "Download of application code is:"

cd /app &>>$logfile

validate $? "changing to app directory"

unzip /tmp/catalogue.zip  &>>$logfile

validate $? "Unzipping the app code"

npm install  &>>$logfile

validate $? "Installing NPM Use as libraries"

cp /root/roboshop-shell/catalogue.service  /etc/systemd/system/catalogue.service  &>>$logfile

validate $? "Copiying the catalogue service"

systemctl daemon-reload  &>>$logfile

validate $? "reloading the service"

systemctl enable catalogue  &>>$logfile

validate $? "enabling the service"

systemctl start catalogue  &>$logfile

validate $? "Restrting the catalogue service"

cp /root/roboshop-shell/mongo.repo  /etc/yum.repos.d/mongo.repo  &>>$logfile

validate $? "copying the mongo.repo"

yum install mongodb-org-shell -y  &>>$logfile

validate $? "installing the mongod"

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js  &>>$logfile

validate $? "Loading the schema"





