data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["679593333241"]
}
resource "aws_instance" "web" {
  ami = "${data.aws_ami.centos.id}"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
  key_name = "${var.aws_key}"  
  instance_type = "${var.itype}"
  tags = {
    Name = "second hw"
  }
  root_block_device {
    delete_on_termination = true
  }
}

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

    provisioner "remote-exec" {
      inline = [
        "sudo setenforce 0",
        "sudo yum repolist",
        "sudo echo '${file("/home/user/terraform/testaws/nginx.repo")}' > ~/nginx.repo",
        "sudo cp ~/nginx.repo /etc/yum.repos.d/nginx.repo",
        "sudo yum -y install epel-release",
        "sudo yum -y install nginx",
        "sudo yum -y install wget",
        "sudo wget  -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
        "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
        "sudo yum -y install java-1.8.0-openjdk.x86_64",
        "sudo yum -y install jenkins",
        #"sudo echo '${file("/home/user/terraform/testaws/nginx.def")}' > ~/default.conf",
        #"sudo cp ~/default.conf /etc/nginx/conf.d/default.conf",
        #"sudo systemctl restart nginx",
        "sudo systemctl start jenkins",
      ]
    }
    provisioner "file" {
    #  source      = "conf/myapp.conf"
     destination = "~/jenkinsaws.com"
     content = "${templatefile("/home/user/terraform/testaws/nginx.tpl", {serverip = "${aws_instance.web.public_ip}"})}"
     }
     provisioner "remote-exec" {
      inline = [
        "sudo cp ~/jenkinsaws.com /etc/nginx/conf.d/default.conf",
        "sudo systemctl restart nginx",
      ]
    }
  }
