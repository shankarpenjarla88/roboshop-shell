#!/bin/bash

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"


login=$(id -u)

Date=$(date +%F)
ScriptName=$0
LogFile=/tmp/$ScriptName-$Date.log

if [ $login -ne 0 ]
then
  echo   -e " $R ERROR: YOU ARE NOT IN THE ADMIN ACCESS,PLEASE LOGIN INTO ADMIN ACCESS $N"
  exit 1
else
  echo -e  " $G NOW YOU ARE IN THE ADMIN ACCESS GOOD TO GO WITH INSTALLATION $N"
fi

yum install git -y &>>$LogFile
