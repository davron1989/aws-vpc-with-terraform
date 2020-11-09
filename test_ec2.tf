data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"]
}

resource "aws_key_pair" "new_key" {
  key_name   = "test_new_bastion"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
   tags = "${var.tags}"
}

resource "aws_instance" "centos7" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.new_key.key_name}"
  subnet_id     = "${aws_subnet.public1.id}"
  security_groups = [
    "${aws_security_group.allow_tls.id}"
  ]
   tags = "${var.tags}"
}
# instance with private subnet
resource "aws_key_pair" "new_key_private" {
  key_name   = "private_instance_bastion"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7bVEZxSZ8XrcBfuwX5OmbWKjYFlb14L+27IEIXOEo+P5igYR0UO+jua7b5RePznLrm3pJ8y2lpVca74v1/aTUCMwW88utleflHfKQEdYKoAVhgWLdTqV/MVzjGy8olBhCH+M1pzHNIJSegDZPrjqwa4O3IB+v0SzG1w3nQruvV1RJJBa2Nda7+GnW8KCzPQBpNQCpZ/h/ZCK5V5baeq1tv6L1c3uAkYdZK3vKHrgB8TU9O0oUrRwmXwDvTJgdI8YG4NSg/KwdbkUFviihQwu1CoIu2sRMVB5qMtOshSGlxOYjXCqy14VBulE2NZpi0f2yVA7T6goW2p/gJdMZKsP1 centos@ip-10-0-101-17.ec2.internal"
   tags = "${var.tags}"
}

resource "aws_instance" "DB" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.new_key_private.key_name}"
  subnet_id     = "${aws_subnet.private1.id}"
  security_groups = [
    "${aws_security_group.my_sql_sg.id}"
  ]
   tags = "${var.tags}"
}

# security groups
# webserver sg
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
      ]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
      ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.tags}"
}

# DB sg
resource "aws_security_group" "my_sql_sg" {
  name        = "my_sql_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
      ]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
      ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.tags}"
}