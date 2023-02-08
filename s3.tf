resource "aws_s3_bucket" "devops30b" {
  bucket = "devops30b"
  tags = {
    Name        = "devops30b"
    Environment = "Dev"
  }
}