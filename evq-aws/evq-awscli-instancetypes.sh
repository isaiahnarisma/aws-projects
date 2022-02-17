#!/bin/bash

# aws configure
# AWS Access Key ID [****************72UR]:
# AWS Secret Access Key [****************D+iG]:
# Default region name [us-west-1]:
# Default output format [json]:

aws ec2 describe-instances --region="us-west-1" | jq -r '.Reservations[].Instances[]|.InstanceId+" "+.InstanceType+" "+(.Tags[] | select(.Key == "Name").Value)'

#list roles

aws iam list-instance-profiles-for-role
--role-name ec2Admin | jq -r

done
