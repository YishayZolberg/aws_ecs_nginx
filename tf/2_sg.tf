#security group for private subnets. allow access only from ALB security group
resource "aws_security_group" "private_sg" {
  name   = "ecs-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 80 
    to_port     = 80
    protocol    = "tcp"
    self        = "false"
    security_groups = [
      "${aws_security_group.elb_sg.id}",
    ]
    description = "http"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name : "ecs-sg"
  }
}

#security group for public subnets. allow inbound only on HTTP/S
resource "aws_security_group" "elb_sg" {
  name   = "elb-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    self        = "false"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    self        = "false"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name : "elb-sg"
  }
}

#sg for sql.
resource "aws_security_group" "db_sg" {
  name   = "db-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    self        = "false"
    cidr_blocks = ["0.0.0.0/0"]
    description = "mysql"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name : "db-sg"
  }
}