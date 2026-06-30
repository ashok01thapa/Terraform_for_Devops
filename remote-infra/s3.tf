resource "aws_s3_bucket" "remote_s3" {
  bucket = "tws-junoon-state-bucket"

  tags = {
    Name        = "tws-junoon-state-bucket"
    Environment = "Dev"
  }
}