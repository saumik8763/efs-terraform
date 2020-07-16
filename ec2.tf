resource "aws_instance" "myinstance" {
  ami             = "ami-0447a12f28fddb066"
  instance_type   = "t2.micro"
  key_name        = "mykey"
  security_groups = ["web-sg"]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("mykey")
    host        = aws_instance.myinstance.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd php git -y",
      "sudo systemctl restart httpd",
      "sudo systemctl enable httpd",
    ]
  }
  provisioner "remote-exec" {

    inline = [
      "sudo yum install httpd amazon-efs-utils -y",
      "sudo sleep 3m",
      "sudo mount -t efs '${aws_efs_file_system.efs.id}':/ /var/www/html",
      "sudo su -c \"echo '${aws_efs_file_system.efs.id}:/ /var/www/html nfs4 defaults,vers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0 0' >> /etc/fstab\"",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo git clone https://github.com/saumik8763/cloud-practice.git /var/www/html",
      "sudo systemctl restart httpd",
      "sudo sed -i 's/cfid/${aws_cloudfront_distribution.cf_distribution.domain_name}/g' /var/www/html/index.html",
    ]
  }

  tags = {
    Name = "SaumikOS"
  }
}