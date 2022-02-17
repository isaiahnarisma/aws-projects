terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.27"
    }
  }

  #required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"   #refers terraform to the `aws configure` credentials we configured in the CLI. `default` is just an environment variable
  region  = "us-west-2" #region where we want to launch this
}

# resource "aws_volume_attachment" "sample-test-server-volume" {
# device_name = "/dev/sdh" #xvdh is reserved for the root volume of the instance; therefore, it is already in use.
  #this configuration attaches another EBS volume to the instance
# volume_id = "${aws_ebs_volume.in-test-sample-volume.id}"
  #"aws_ebs_volume.in-test-sample-volume.id" #"vol-03a238c7180eab541" #references the resource name as noted in the aws_ebs_volume resource block
# instance_id = "${aws_instance.in-test-server.id}"
  #"aws_instance.in-test-server.id" #"i-063527159feee9f9b" #references the aws_instance name as defined in the aws_instance resource block
# }


resource "aws_instance" "in-test-server" { #type of resource we want to launch, followed by the name
  #ami = "ami-830c94e3" #amazon machine image, the type of resource we want to launch
  ami           = "ami-066333d9c572b0680" #amazon linux 2 AMI x86 instance
  instance_type = "t2.micro"              #size of the instance, this one is a free tier eligible
  availability_zone = "us-west-2a"
  ebs_block_device {
    device_name = "/dev/sdh"
    delete_on_termination = "true"
    # encrypted = "true" needs a reference to aws-key-management-service for encryption keys
  } #this parameter effectively removes the need for the external resources "aws_ebs_volume" and aws_volume_attachment"
  tags = {
    Name = "sample-test-server" #example tags for organization
  }
  #we can launch instances with the `configure instance details` at a later date, this just is the basics
  #we can write to add storage as well, step 4 in the aws instance launch workflow
  #we can also configure security group in the aws instance from terraform
}

#resource "aws_ebs_volume" "in-test-sample-volume" {
# availability_zone = "us-west-2a"
# size = 1

#}
