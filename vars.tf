variable "region" {
  description = "The region you waant to launch"
  default = "us-west-2"
}

variable "shared_credentials_file" {
  description = "The credential file of the user"
  default = "/users/sdoppalapudi/.aws/credentials"
}

variable "profile" {
  description = "The profile you want to login"
  default = "aws-nonprodadmin"
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  default = "ami-e0db1a98"
}

variable "instance_type" {
  description = "The type of instance to start"
  default = "t2.xlarge"
}

variable "key_name" {
  description = "The key name to use for the instance"
  default     = "devops-key"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  default = "subnet-4eaxxxxxxxx"
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = "list"
  default = ["sg-e57xxxxxxxx", "sg-f47xxxxxxx"]
}

locals {
  common_tags = {
    ResourceOwner = "sai Doppalapudi | doppalapudisaikumar@gmail.com"
    CostCenter = "78-900"
    Application = "ADSP-CLOUD-POC"
    Team = "Exodus"
  }
}

