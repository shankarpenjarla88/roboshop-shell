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

cp /root/roboshop-shell/mongo.repo   /etc/yum.repos.d/mongo.repo &>> $logfile

validate $? "Copied mongo.repo into yum.repo.d"

yum install mongodb-org -y

validate $? "Installation of mongodb is"

systemctl enable mongod

validate $? "enabling is:"

systemctl start mongod

validate $? "restart is:"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

systemctl restart mongod

validate $? "restart is:"
