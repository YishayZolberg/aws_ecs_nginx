/*
resource "aws_network_acl" "nacl-public" {
  vpc_id = aws_vpc.main.id
  subnet_ids = [ aws_subnet.public_subnets-1.id, aws_subnet.public_subnets-2.id ]
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }
  tags = {
    Name = "yz-nacl-public"
  }
}

resource "aws_network_acl" "nacl-private" {
  vpc_id = aws_vpc.main.id
  subnet_ids = [ aws_subnet.private_subnets-1.id, aws_subnet.private_subnets-2.id ]
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }
  tags = {
    Name = "yz-nacl-private"
  }
}

resource "aws_network_acl" "nacl-public" {
  vpc_id = aws_vpc.main.id
  subnet_ids = [ aws_subnet.public_subnets-1.id, aws_subnet.public_subnets-2.id ]
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  egress {
    protocol   = "tcp"
    rule_no    = 201
    action     = "allow"
    cidr_block = "0.0.0.0/0"#"10.0.2.0/24"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"#"10.0.2.0/24"
    from_port  = 1024
    to_port    = 65535
  }
  tags = {
    Name = "yz-nacl-public"
  }
}

resource "aws_network_acl" "nacl-private" {
  vpc_id = aws_vpc.main.id
  subnet_ids = [ aws_subnet.private_subnets-1.id, aws_subnet.private_subnets-2.id ]
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"#"10.0.0.0/24"
    from_port  = 1024
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"#"10.0.0.0/24"
    from_port  = 80
    to_port    = 80
  }
  tags = {
    Name = "yz-nacl-private"
  }
}
*/