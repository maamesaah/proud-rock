# Create a VPC

resource "aws_vpc" "Prod-rock-VPC" {
  cidr_block       = var.cidr-for-vpc
  instance_tenancy = "default"

  tags = {
    Name = "maame-vpc"
  }
}


# Create a public subnet


resource "aws_subnet" "public_sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.cidr-for-public_sub1

  tags = {
    Name = "public_sub1"
  }
}


# Create a public subnet


resource "aws_subnet" "public_sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.cidr-for-public_sub2

  tags = {
    Name = "public_sub2"
  }
}


# Create a private subnet


resource "aws_subnet" "private_sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.cidr-for-private_sub1

  tags = {
    Name = "private_sub1"
  }
}



# Create a private subnet


resource "aws_subnet" "private_sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.cidr-for-private_sub2

  tags = {
    Name = "private_sub2"
  }
}



# Create a private route table

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id


  tags = {
    Name = "private_route_table"
  }
}


# Create a public route table

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id


  tags = {
    Name = "public_route_table"
  }
}

# Create a private route table association


resource "aws_route_table_association" "private_route_table_association1" {
  subnet_id      = aws_subnet.private_sub1.id
  route_table_id = aws_route_table.private_route_table.id
}


# Create a private route table association


resource "aws_route_table_association" "private_route_table_association2" {
  subnet_id      = aws_subnet.private_sub2.id
  route_table_id = aws_route_table.private_route_table.id
}


# Create a public route table association

resource "aws_route_table_association" "public_route_table_association1" {
  subnet_id      = aws_subnet.public_sub1.id
  route_table_id = aws_route_table.public_route_table.id
}



# Create a public route table association

resource "aws_route_table_association" "public_route_table_association2" {
  subnet_id      = aws_subnet.public_sub2.id
  route_table_id = aws_route_table.public_route_table.id
}


# Create an internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "igw"
  }
}


# Create a route for your internet gateway

resource "aws_route" "public-igw-route" {
  route_table_id            = aws_route_table.public_route_table.id
  gateway_id                = aws_internet_gateway.igw.id
  destination_cidr_block    = var.cidr-public-igw-route
}


# Create an Elastic IP
resource "aws_eip" "EIP_for_NG" {
  vpc                       = true
  associate_with_private_ip = var.cidr-for-private_sub1
  depends_on                = [aws_internet_gateway.igw]
}


# Create a Nat Gateway

resource "aws_nat_gateway" "nat_gateway" { 
allocation_id   = aws_eip.EIP_for_NG.id
  subnet_id     = aws_subnet.private_sub2.id 
}


# Create a route for Nat Gateway

resource "aws_route" "Nat-GW-association_with-private_RT" {
route_table_id         = aws_route_table.private_route_table.id
nat_gateway_id         = aws_nat_gateway.nat_gateway.id
destination_cidr_block = var.cidr-nat-gateway-route
}


