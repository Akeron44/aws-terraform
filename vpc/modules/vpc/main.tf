resource "aws_vpc" "akeron_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "akeronVpc"
  }
}

resource "aws_subnet" "akeron_public_subnet" {
  vpc_id                  = aws_vpc.akeron_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "akeronPublicSubnet"
  }
}
resource "aws_subnet" "akeron_private_subnet" {
  vpc_id            = aws_vpc.akeron_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1c"

  tags = {
    Name = "akeronPrivateSubnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.akeron_vpc.id

  tags = {
    Name = "akeronIgw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.akeron_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "akeronRouteTable"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.akeron_public_subnet.id
  route_table_id = aws_route_table.route_table.id
}


