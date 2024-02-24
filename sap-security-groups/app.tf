resource "aws_security_group" "AppSecurityGroup" {
  name        = "${var.conf_name}_App_Sec_grp"
  vpc_id      = var.vpc_id
  description = "Enable external access to the HANA leading server and allow communication to subordinate servers."
}

# Allow all traffic within the security group
resource "aws_security_group_rule" "AppSecurityGroupSelf" {
  type              = "ingress"
  self              = true
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.AppSecurityGroup.id
}

# Allow all outbound traffic
resource "aws_security_group_rule" "AppSecurityGroupOutbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.AppSecurityGroup.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow all TCP traffic from the DB security group
resource "aws_security_group_rule" "AllowAllDBTCP" {
  type                     = "ingress"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.AppSecurityGroup.id
  source_security_group_id = aws_security_group.DBSecurityGroup.id
}

# Ports that need to be accessible for external parties

locals {
  AppSecurityGroupPorts = {
    "22" : { "from" : 22, "to" : 22 },
    "3200" : { "from" : 3200, "to" : 3399 },
    "3600" : { "from" : 3600, "to" : 3699 },
    "4237" : { "from" : 4237, "to" : 4237 },
    "50000" : { "from" : 50000, "to" : 59901 },
    "8080" : { "from" : 8080, "to" : 8080 },
    "8443" : { "from" : 8443, "to" : 8443 }
  }
}

resource "aws_security_group_rule" "AppSecurityGroupExternalCIDRs" {
  for_each          = length(var.external_cidrs) > 0 ? local.AppSecurityGroupPorts : {}
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = "tcp"
  cidr_blocks       = var.external_cidrs
  security_group_id = aws_security_group.AppSecurityGroup.id
}


resource "aws_security_group_rule" "AppSecurityGroupExternalGroups" {
  for_each          = length(var.external_groups) > 0 ? local.AppSecurityGroupPorts : {}
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = "tcp"
  cidr_blocks       = var.external_groups
  security_group_id = aws_security_group.AppSecurityGroup.id
}
