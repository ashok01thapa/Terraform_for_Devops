variable "env" {
    description = "This is the environment for mine infra"
    type = string
}

variable "bucket_name" {
    description = "This is the bucket name for mine infra"
    type = string       
}
variable "instance_count" {
    description = "This is the no. of ec2 isntance"
    type = number
}

variable "instance_type" {
    description = "This is the instance type for my ec2 infra"
    type = string
}

variable "ec2_ami_id" {
    description = "This is the instance AMI ID for my ec2 infra"
    type = string
}

variable "hash_key"{
    description = "This is the hash key for my dynamodb table"
    type = string
}
