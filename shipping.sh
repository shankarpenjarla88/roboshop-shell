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

yum install maven -y

validate $? "Maven Installation"

useradd roboshop

mkdir /app

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip

cd /app

unzip /tmp/shipping.zip

cd /app

mvn clean package

mv target/shipping-1.0.jar shipping.jar

systemctl daemon-reload

systemctl enable shipping 

systemctl start shipping

yum install mysql -y 

mysql -h mysql.lxio.online -uroot -pRoboShop@1 < /app/schema/shipping.sql 

systemctl restart shipping
