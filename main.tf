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
}
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
        "sudo yum update -y",
      ]
    }
  }
