provider "aws" {
        region = "${var.region}"
        shared_credentials_file= "${var.shared_credentials_file}"
        profile = "${var.profile}"
        
}

resource "aws_instance" "Rhel7" {
        ami = "${var.ami}"
        instance_type = "${var.instance_type}"
	    subnet_id = "${var.subnet_id}"
        key_name = "${var.key_name}"
        vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
        tags = "${merge(
            local.common_tags,
            map(
             "Name", "terraform-AnsibleTower3.2.5-RHEL"
            )
        )}"        
        user_data=<<-EOF
         #!/bin/bash -x
         sudo su  
         sudo yum install -y http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
         sudo yum install  -y ansible
         sudo yum install -y wget
         cd /home/ec2-user
         sudo wget https://s3-us-west-2.amazonaws.com/ansible-tower-bucket/ansible-tower-setup-3.2.5.tar.gz
         sudo tar -xvzf ansible-tower-setup-3.2.5.tar.gz
         sudo cd ansible-tower-setup-3.2.5
         sudo rm -rf /home/ec2-user/ansible-tower-setup-3.2.5/inventory
         sudo wget https://s3-us-west-2.amazonaws.com/ansible-tower-bucket/inventory
         sudo cp inventory /home/ec2-user/ansible-tower-setup-3.2.5/ 
         sudo /home/ec2-user/ansible-tower-setup-3.2.5/setup.sh 
		     EOF
}

output "id" {
  description = "List of IDs of instances"
  value       = ["${aws_instance.Rhel7.*.id}"]
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = ["${aws_instance.Rhel7.*.private_ip}"]
}