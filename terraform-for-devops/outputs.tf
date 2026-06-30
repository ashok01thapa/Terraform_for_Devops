# Outputs for count

# output "ec2_public_ip" {
#     value = aws_instance.my_instance[*].public_ip
# }

# output "ec2_instance_id" {
#     value = aws_instance.my_instance[*].public_dns
# }

# output "ec2_private_ip" {
#     value = aws_instance.my_instance[*].private_ip
# } 

# Outputs for For each
output "ec2_public_ip" {
    value = [
        for instance in aws_instance.my_instance : instance.public_ip
    ]
}