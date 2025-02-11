# Security group configuration

# Default administration port
#tfsec:ignore:aws-ec2-no-public-ingress-sgr tfsec:ignore:aws-ec2-no-public-egress-sgr tfsec:ignore:aws-ec2-add-description-to-security-group-rule
resource "aws_security_group" "administration" {
  name        = "${var.env}-administration"
  description = "Allow default administration service"
  vpc_id      = aws_vpc.terraform.id
  tags = {
    Name = "${var.env}-administration"
  }

  # Open ssh port
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow icmp
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Open access to public network
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Open web port
#tfsec:ignore:aws-ec2-no-public-ingress-sgr tfsec:ignore:aws-ec2-no-public-egress-sgr tfsec:ignore:aws-ec2-add-description-to-security-group-rule
resource "aws_security_group" "web" {
  name        = "${var.env}-web"
  description = "Allow web incgress trafic"
  vpc_id      = aws_vpc.terraform.id
  tags = {
    Name = "${var.env}-web"
  }

  # http port
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # https port
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Open access to public network
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Open database port
#tfsec:ignore:aws-ec2-no-public-ingress-sgr tfsec:ignore:aws-ec2-no-public-egress-sgr tfsec:ignore:aws-ec2-add-description-to-security-group-rule
resource "aws_security_group" "db" {
  name        = "${var.env}-db"
  description = "Allow db incgress trafic"
  vpc_id      = aws_vpc.terraform.id
  tags = {
    Name = "${var.env}-db"
  }

  # db port
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Open access to public network
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

