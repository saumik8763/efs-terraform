resource "aws_key_pair" "key" {
  key_name   = "mykey"
  public_key = file("mykey.pub")
}