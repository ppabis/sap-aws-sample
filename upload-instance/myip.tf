# This thing saves your public IP

data "external" "my-ip" {
  program = ["sh", "-c", "curl -s https://api.ipify.org/?format=json"]
}

locals {
  my-ip-cidr = "${data.external.my-ip.result.ip}/32"
}
