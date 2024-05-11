#!/bin/bash

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

Date=$(date +%F)
Scriptname=$0
Logfile=/tmp/$Scriptname-$Date.log

validate() {

    if [ $1 -ne 0 ]
    then
      echo -e " $R INSTALLATION IS FAILED $N"
    else
      echo -e " $G INSTALLATION IS SUCCESS $N"
    fi

}

userId=$(id -u)

installs=$(yum list installed  | grep git)



for i in $@
do
  if [ $installs -ne 0 ]
  then
    echo -e "$Y Already installed dont need to install again $N"
     exit 1
  else
    echo -e "$G Get ready for installation"
     yum install $i -y &>>$Logfile
 fi
done 


validate $? "Installations is :"
  

