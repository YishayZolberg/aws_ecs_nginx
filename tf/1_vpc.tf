#create the vpc
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "yz-vpc"
  }
}

#create all subnets in 2 az 
resource "aws_subnet" "public_subnets-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "${var.aws_region}a"
  tags = {
    Name : "public_subnets-1a"
  }
}
resource "aws_subnet" "public_subnets-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_region}b"
  tags = {
    Name : "public_subnets-2b"
  }
}
resource "aws_subnet" "private_subnets-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}a"
  tags = {
    Name : "private_subnets-1a"
  }
}
resource "aws_subnet" "private_subnets-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.aws_region}b"
  tags = {
    Name : "private_subnets-2b"
  }
}

#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "yz-igw"
  }
}

#create nat in public subnet to get access from the private subnets
resource "aws_nat_gateway" "myNATgw" {
  allocation_id = aws_eip.EIP_Natgw.id
  subnet_id     = aws_subnet.public_subnets-1.id
  tags = {
    Name = "yz-NATgw"
  }
  #depends_on = [aws_internet_gateway.igw]
}

#pool eip
resource "aws_eip" "EIP_Natgw" {
  vpc = true
}

#create route table to associate nat with the private subnets
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.myNATgw
  ]
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.myNATgw.id
  }
  tags = {
    Name = "yz-private-rt"
  }
}
resource "aws_route_table_association" "private-subnet-1_route" {
  subnet_id      = aws_subnet.private_subnets-1.id
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}
resource "aws_route_table_association" "private-subnet-2_route" {
  subnet_id      = aws_subnet.private_subnets-2.id
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

#create route table to associate igw with the public subnets
resource "aws_route_table" "IGW-RT" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public-subnet-1_route" {
  subnet_id      = aws_subnet.public_subnets-1.id
  route_table_id = aws_route_table.IGW-RT.id
}
resource "aws_route_table_association" "public-subnet-2_route" {
  subnet_id      = aws_subnet.public_subnets-2.id
  route_table_id = aws_route_table.IGW-RT.id
}