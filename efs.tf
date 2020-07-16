resource "aws_efs_file_system" "efs" {
  creation_token   = "efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags = {
    Name = "EFS-File-System"
  }
}
resource "aws_efs_mount_target" "efs-mt-a" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = "subnet-68711b24"
  security_groups = [aws_security_group.web-sg.id]
}

resource "aws_efs_mount_target" "efs-mt-b" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = "subnet-7cd46807"
  security_groups = [aws_security_group.web-sg.id]
}

resource "aws_efs_mount_target" "efs-mt-c" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = "subnet-948386fc"
  security_groups = [aws_security_group.web-sg.id]
}