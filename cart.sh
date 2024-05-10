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

validate $? "setting up NPM source"

yum install nodejs -y

useradd roboshop

mkdir /app

curl -L -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip

cd /app 

unzip /tmp/cart.zip

cd /app 

cp /root/shell-scripts/roboshop-shell/cart.service  /etc/systemd/system/cart.service

systemctl daemon-reload

systemctl enable cart 

systemctl start cart