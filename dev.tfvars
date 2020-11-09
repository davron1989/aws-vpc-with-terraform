region = "us-east-1"
region_name = "n.verginia"

vpc_cidr = "10.0.0.0/16"

private-subnet1 = "10.0.1.0/24"
private-subnet2 = "10.0.2.0/24"
private-subnet3 = "10.0.3.0/24"

public-subnet1 = "10.0.101.0/24"
public-subnet2 = "10.0.102.0/24"
public-subnet3 = "10.0.103.0/24"

public_route_table_cidr = "0.0.0.0/0"

az1 = "a"
az2 = "b"
az3 = "c"

tags = {
    Name            = "VPC_Project"
    Environment     = "Dev"
    Department      = "IT"
    Team            = "DevOps"
    Created_by      = "Davron"
    Billing         = "CFO"
}