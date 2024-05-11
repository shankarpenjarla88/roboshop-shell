#!/bin/bash

Names=("mongodb" "catalogue" "cart" "mysql" "redis" "rabbitmq" "user" "shipping" "payment" "dispatch" "web")
Image_id=ami-0f3c7d07486cad139 
Instance_Type="t2.micro"
Security_grp=sg-0c9760a3839e63c1dcho 

for i in "${Names[@]}"
do
  
  echo "Creatio of Instances:$i"

  aws ec2 run-instances --image-id $Image_id --count 1 --instance-type $Instance_Type --security-group-ids $Security_grp 
  
done 