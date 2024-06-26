#!/bin/bash

Names=("mongodb" "catalogue" "cart" "mysql" "redis" "rabbitmq" "user" "shipping" "payment" "dispatch" "web")
Image_id=ami-0f3c7d07486cad139
Security_grp=sg-0c9760a3839e63c1d
Instance_type=""



for i in "${Names[@]}"
do
    if [[ $i == "mongodb" || $i == "mysql" ]]
    then
      Instance_type="t3.medium" 
    else
      Instance_type="t2.micro"
    fi 
    echo "Creatio of Instances:$i"
    aws ec2 run-instances --image-id $Image_id --count 1  --instance-type $Instance_type  --security-group-ids $Security_grp  --tag-specifications "ResourceType=instance,Tags=[{Key=$Names,Value=$i}]"
done 