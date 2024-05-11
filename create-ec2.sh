#!/bin/bash

Names=("mongodb" "catalogue" "cart" "mysql" "redis" "rabbitmq" "user" "shipping" "payment" "dispatch" "web")


for i in "${Names[@]}"
do

  echo "Creatio of Instances:$i"
  aws ec2 run-instances --image-id ami-0f3c7d07486cad139   --count 1 --instance-type t2.micro --security-group-ids sg-0c9760a3839e63c1dcho 
done 