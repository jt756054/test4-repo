/* ##creating sumens-vpc
resource "aws_vpc" "sumens-vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy

  tags = {
    Name        = "sumens-vpc"
    Environment = "local.environment"
  }
}

##creating public subnets
resource "aws_subnet" "public-subnets" {
  for_each = var.public_subnet_cidr

  vpc_id            = aws_vpc.sumens-vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name        = each.key
    Environment = "local.environment"
  }
}

##creating a private subnet
resource "aws_subnet" "private-subnets" {
  for_each = var.private_subnet_cidr

  vpc_id            = aws_vpc.sumens-vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name        = each.key
    Environment = "local.environment"
  }
}

##creating igw and associating it the vpc
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sumens-vpc.id

  tags = {
    Name        = "sumens-igw"
    Environment = "local.environment"
  }
}

##creating public rt
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.sumens-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "sumens-public-rt"
    Environment = "local.environment"
  }
}

##creating rt association with public subnet
resource "aws_route_table_association" "public-subnet" {
  for_each = var.public_subnet_cidr

  subnet_id      = aws_subnet.public-subnets[each.key].id
  route_table_id = aws_route_table.public-rt.id
}

##creating eip
resource "aws_eip" "dev-eip" {
  domain = "vpc"

  tags = {
    Name        = "sumens-vpc-eip"
    Environment = "local.environment"
  }
}

##creating ngw
resource "aws_nat_gateway" "sumens-ngw" {
  allocation_id = aws_eip.dev-eip.id
  subnet_id     = aws_subnet.public-subnets["sumens-public-sub-1"].id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name        = "sumens-ngw"
    Environment = "local.environment"
  }
}

##creating private rt
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.sumens-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.sumens-ngw.id
  }

  tags = {
    Name        = "sumens-private-rt"
    Environment = "local.environment"
  }
}

##creating rt association with private subnet
resource "aws_route_table_association" "privare-subnet" {
  for_each = tomap(var.private_subnet_cidr)

  subnet_id      = aws_subnet.private-subnets[each.key].id
  route_table_id = aws_route_table.private-rt.id
}

*/