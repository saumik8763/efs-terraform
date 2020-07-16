resource "aws_s3_bucket" "bucket" {
  bucket = "test-bucket"
  acl    = "public-read"
  tags = {
    Name        = "Code"
    Environment = "prod"
  }
}

resource "aws_s3_bucket_object" "file_upload" {
  depends_on = [
    aws_s3_bucket.bucket,
  ]
  bucket = "test-bucket"
  key    = "image.jpg"
  source = "image.jpg"
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
	 {
         "Sid":"AllowPublicRead",
         "Effect":"Allow",
         "Principal": {
            "AWS":"*"
         },
         "Action":"s3:GetObject",
         "Resource":"arn:aws:s3:::saumik-test-bucket/*"
      }
    ]
}
POLICY
}