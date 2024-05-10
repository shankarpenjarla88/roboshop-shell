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

yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

yum module enable redis:remi-6.2 -y

yum install redis -y 

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf  /etc/redis/redis.conf

systemctl enable redis

systemctl start redis



