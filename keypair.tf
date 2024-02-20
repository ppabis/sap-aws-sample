resource "aws_key_pair" "SAP" {
  key_name   = "SAP"
  public_key = file("~/.ssh/id_ed25519.pub")
}
