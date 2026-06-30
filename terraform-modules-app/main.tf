# dev infrastructure

module "dev-infra" {
    source = "./infra-app"
    env = "dev"
    bucket_name = "tws-infra-app-bucket"
    instance_count = 1
    instance_type = "t2.micro"
    ec2_ami_id = "ami-0c02fb55956c7d316"
    hash_key = "studentID"
}

module "prd-infra" {
    source = "./infra-app"
    env = "prd"
    bucket_name = "tws-infra-app-bucket"
    instance_count = 2
    instance_type = "t2.medium"
    ec2_ami_id = "ami-0c02fb55956c7d316"
    hash_key = "studentID"
}

module "stg-infra" {
    source = "./infra-app"
    env = "stg"
    bucket_name = "tws-infra-app-bucket"
    instance_count = 1
    instance_type = "t2.small"
    ec2_ami_id = "ami-0c02fb55956c7d316"
    hash_key = "studentID"
}