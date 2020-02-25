# data "aws_ami" "centos" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["CentOS Linux 7 x86_64 HVM EBS *"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#   owners = ["679593333241"]
# }
# resource "aws_instance" "web" {
#   ami = "${ami-0df0e7600ad0913a9}"
#   vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
#   key_name = "${var.aws_key}"  
#   instance_type = "${var.itype}"
#   tags = {
#     Name = "second hw"
#   }
#   root_block_device {
#     delete_on_termination = true
#   }
# }

terraform {
  backend "s3" {
    bucket = "kapitantestbucket"
    key    = "terraforrm.tfstate"
    region = "eu-central-1"
  }
}


# output "instance_ip_addr" {
#   value = "ssh -i ./.ssh/testkye.pem centos@${aws_instance.web.public_ip}"
# }

#  resource "aws_vpc" "main" {
#    cidr_block = "10.0.0.0/16"
#  }

#  resource "aws_subnet" "main" {
#    for_each = var.subent_numbers
#    vpc_id     = aws_vpc.main.id
#    cidr_block = cidrsubnet(aws_vpc.main.cidr_block,4,each.key)
#    tags = {
#     #  Name = "Main - ${each.key}"
#    }
#  }

#data "template_file" "init" {
#  template = "${file("${path.module}/home/user/terraform/testaws/nginx.def")}"
#  destination = "~/default.conf"
#  vars = {
#    consul_address = "${aws_instance.web.private_ip}"
#  }
#}
resource "null_resource" "example_provisioner" {

    connection {
      type = "ssh"
      host = "${aws_instance.web.public_ip}"
      user = "${var.suser}"
      private_key = "${file("/home/user/.ssh/testkye.pem")}"
      port = "${var.sport}"
      agent = true
    }

  #   provisioner "remote-exec" {
  #     inline = [
  #       "sudo setenforce 0",
  #       "sudo yum repolist",
  #       "sudo echo '${file("/home/user/terraform/testaws/nginx.repo")}' > ~/nginx.repo",
  #       "sudo echo '${file("/home/user/terraform/testaws/run.dem")}' > ~/rundeck.cfg",
  #       "sudo echo '${file("/home/user/terraform/testaws/run.service")}' > ~/rundeck.service",
  #       "sudo cp ~/nginx.repo /etc/yum.repos.d/nginx.repo",
  #       "sudo cp ~/rundeck.cfg /etc/rundeck.cfg",
  #       "sudo cp ~/rundeck.service /lib/systemd/system/rundeck.service",.
  #       "sudo yum -y install epel-release",
  #       "sudo yum -y install nginx",
  #       "sudo yum -y install wget",
  #       "sudo wget  -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
  #       "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
  #       "sudo yum -y install java-1.8.0-openjdk.x86_64",
  #       "sudo yum -y install jenkins",
  #       #"sudo echo '${file("/home/user/terraform/testaws/nginx.def")}' > ~/default.conf",
  #       #"sudo cp ~/default.conf /etc/nginx/conf.d/default.conf",
  #       #"sudo systemctl restart nginx",
  #       "wget https://dl.bintray.com/rundeck/rundeck-maven/rundeck-3.1.3-20191204.war",
  #       "sudo cp ~/rundeck-3.1.3-20191204.war /opt/rundeck-3.1.3-20191204.war",
  #     ]
  #   }
  #   provisioner "file" {
  #   #  source      = "conf/myapp.conf"
  #    destination = "~/nginx.com"
  #    content = "${templatefile("/home/user/terraform/testaws/nginx.tpl", {serverip = "${aws_instance.web.public_ip}"}, )}"
  #    }
  #    provisioner "remote-exec" {
  #     inline = [
  #       "sudo cp ~/nginx.com /etc/nginx/conf.d/default.conf",
  #       "sudo systemctl daemon-reload",
  #       "sudo systemctl start jenkins",
  #       "sudo systemctl restart nginx",
  #       "sudo systemctl start rundeck",
  #       #"cat /var/lib/jenkins/secrets/initialAdminPassword",
  #     ]
  #   }
 }
#vpc
#igw
#routs
#routetables
#natgateway
#EIP
#добавить БД в vpc 
#создать
