#!/bin/bash

# aws configure
# AWS Access Key ID [****************72UR]:
# AWS Secret Access Key [****************D+iG]:
# Default region name [us-west-1]:
# Default output format [json]:

for region in $(aws ec2 describe-regions --query "Regions[*].RegionName"
--output text | tr "\t" "\n" | grep "$1");
do echo "\nListing instances in region:'$region'...";
aws ec2 describe-instances --region $region --output table
--query "Reservations[*].Instances[*].{
    InstanceId: InstanceId,
    KeyName: KeyName,
    Status: State.Name,
    AvailabilityZone: Placement.AvailabilityZone,
    PrivateDns: PrivateDnsName,
    PrivateIp: PrivateIpAddress,
    PublicDns: PublicDnsName,
    PublicIp: PublicIpAddress,
    SubnetId: SubnetId,
    Tags: Tags[?Key==\`Name\`]|[0].Value
}"; done
