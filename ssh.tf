resource "aws_security_group" "ssh" {
    name = "thirdlesson"
    description = "second hw group"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
<<<<<<< HEAD

=======
       
>>>>>>> c2455775c2119b1d90e78de0d99003026c3852cc
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
