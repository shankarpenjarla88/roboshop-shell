#!/bin/bash

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

validate() {

    if [ $1 -ne 0 ]
    then
      echo -e " $R INSTALLATION IS FAILED $N"
    else
      echo -e " $G INSTALLATION IS SUCCESS $N"
    fi

}

userId=$(id -u)

for i in $@
do 
  echo "INSTALLING THE $i"
  yum install $i -y
done

validate $? "INSTALLATION IS:"