data "aws_ssm_parameter" "al2023" { name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-arm64" }
data "aws_vpc" "default" { default = true }

resource "aws_security_group" "upload-instance" {
  name        = "upload-instance-sg"
  description = "upload-instance-sg"
  vpc_id      = data.aws_vpc.default.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my-ip-cidr]
  }
}

resource "aws_key_pair" "upload-instance" {
  key_name   = "upload-instance"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "upload-instance" {
  instance_type               = "t4g.nano"
  ami                         = data.aws_ssm_parameter.al2023.value
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.upload-instance.id]
  iam_instance_profile        = aws_iam_instance_profile.UploadInstanceRole.name
  key_name                    = aws_key_pair.upload-instance.key_name
  user_data                   = <<-EOF
  #!/bin/bash
  yum update -y
  # install java 11
  yum install java-11-amazon-corretto-headless -y
  EOF
  root_block_device {
    volume_size = 16 # At least 16 GB
  }
}

output "upload_instance_ip" {
  value = aws_instance.upload-instance.public_ip
}
