#Create VPC
resource "aws_vpc" "vpc_one" {
  provider   = aws
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Application-vpc"
  }
}

#Create IGW
resource "aws_internet_gateway" "igw" {
  # provider = aws
  vpc_id = aws_vpc.vpc_one.id
}

#Create subnet 1
resource "aws_subnet" "subnet_1" {
  # provider = aws
  availability_zone = "${var.region}a"
  vpc_id            = aws_vpc.vpc_one.id
  cidr_block        = "10.0.1.0/24"
}

#Create subnet 2
resource "aws_subnet" "subnet_2" {
  # provider = aws
  availability_zone = "${var.region}b"
  vpc_id            = aws_vpc.vpc_one.id
  cidr_block        = "10.0.2.0/24"
}


#Create Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_one.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public"
  }
}

#Route table association with subnet_1
resource "aws_route_table_association" "subnet_one_public_access" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.public_rt.id

}

#Route table association with subnet_2
resource "aws_route_table_association" "subnet_two_public_access" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.public_rt.id

}