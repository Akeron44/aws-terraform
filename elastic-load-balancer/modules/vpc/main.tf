resource "aws_vpc" "vpc_example" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "akeronVpc"
  }
}

resource "aws_subnet" "public_subnet_example" {
  vpc_id                  = aws_vpc.vpc_example.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "akeronPublicSubnet"
  }

}
resource "aws_subnet" "private_subnet_example" {
  vpc_id            = aws_vpc.vpc_example.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "akeronPrivateSubnet"
  }

}

resource "aws_eip" "eip_example" {
  domain = "vpc"

  tags = {
    Name = "akeroneip"
  }
}

resource "aws_nat_gateway" "ngw_example" {
  subnet_id         = aws_subnet.public_subnet_example.id
  connectivity_type = "public"
  allocation_id     = aws_eip.eip_example.id

  tags = {
    name = "akeronNgw"
  }
}

resource "aws_internet_gateway" "igw_example" {
  vpc_id = aws_vpc.vpc_example.id

  tags = {
    Name = "akeronIgw"
  }
}

resource "aws_route_table" "route_table_example" {
  vpc_id = aws_vpc.vpc_example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_example.id
  }

  tags = {
    Name = "akeronRouteTable"
  }
}

resource "aws_route_table" "route_table2_example" {
  vpc_id = aws_vpc.vpc_example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw_example.id
  }

  tags = {
    Name = "akeronPrivateRouteTable"
  }
}

resource "aws_route_table_association" "rta_example" {
  subnet_id      = aws_subnet.public_subnet_example.id
  route_table_id = aws_route_table.route_table_example.id
}

resource "aws_route_table_association" "rta2_example" {
  subnet_id      = aws_subnet.private_subnet_example.id
  route_table_id = aws_route_table.route_table2_example.id
}
