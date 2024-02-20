resource "aws_iam_role" "UploadInstanceRole" {
  name = "UploadInstanceRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "UploadInstanceRole" {
  name = aws_iam_role.UploadInstanceRole.name
  role = aws_iam_role.UploadInstanceRole.name
}

resource "aws_iam_role_policy_attachment" "S3Full" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.UploadInstanceRole.name
}
