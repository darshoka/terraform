provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "example" {
  ami = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name= "TF Example"
  }
}
resource  "aws_security_group" "instance" {
  name = "TF security group"
  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
}