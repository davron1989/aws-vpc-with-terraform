#vpc
resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  tags       = "${var.tags}"
}

# Subnet blocks
#####################################################################################################
# Privare subnets 
resource "aws_subnet" "private1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private-subnet1}"
  availability_zone = "${var.region}${var.az1}"
  tags              = "${var.tags}"
}

resource "aws_subnet" "private2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private-subnet2}"
  availability_zone = "${var.region}${var.az2}"
  tags              = "${var.tags}"
}

resource "aws_subnet" "private3" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private-subnet3}"
  availability_zone = "${var.region}${var.az3}"
  tags              = "${var.tags}"
}

# Public subnets
resource "aws_subnet" "public1" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.public-subnet1}"
  availability_zone       = "${var.region}${var.az1}"
  map_public_ip_on_launch = true
  tags                    = "${var.tags}"
}

resource "aws_subnet" "public2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.public-subnet2}"
  availability_zone       = "${var.region}${var.az2}"
  map_public_ip_on_launch = true
  tags                    = "${var.tags}"
}

resource "aws_subnet" "public3" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.public-subnet3}"
  availability_zone       = "${var.region}${var.az3}"
  map_public_ip_on_launch = true                      # enables public ip address auto assignment
  tags                    = "${var.tags}"
}

##############################################################################################################

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
  tags   = "${var.tags}"
}

#NAT Gateway
// resource "aws_nat_gateway" "gw" {
//   allocation_id = aws_eip.nat.id
//   subnet_id     = aws_subnet.example.id
//   tags = "${var.tags}"

# Elastic IP for NAT
resource "aws_eip" "nat" {
  vpc  = true
  tags = "${var.tags}"
}

# Route table
resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.main.id}"
  tags   = "${var.tags}"

  route {
    cidr_block = "${var.public_route_table_cidr}"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

# Route Table association
resource "aws_route_table_association" "rta1" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.rt.id}"
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.rt.id}"
}

resource "aws_route_table_association" "rta3" {
  subnet_id      = "${aws_subnet.public3.id}"
  route_table_id = "${aws_route_table.rt.id}"
}
