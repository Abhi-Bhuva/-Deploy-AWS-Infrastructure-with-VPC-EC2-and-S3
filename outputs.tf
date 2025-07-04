output "ec2_:public_ip" {
  description = "Public IP of EC2 Instance"
  value       = aws_instance.web.public_ip
  }

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}
