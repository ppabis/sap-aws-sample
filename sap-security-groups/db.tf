resource "aws_security_group" "DBSecurityGroup" {
  name        = "${var.conf_name}_DB_Sec_grp"
  vpc_id      = var.vpc_id
  description = "Enable external access to the HANA leading server and allow communication to subordinate servers."
}

# Allow all traffic within the security group
resource "aws_security_group_rule" "DBSecurityGroupSelf" {
  type              = "ingress"
  self              = true
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.DBSecurityGroup.id
}

# Allow all outbound traffic
resource "aws_security_group_rule" "DBSecurityGroupOutbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.DBSecurityGroup.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow all TCP traffic from the App security group
resource "aws_security_group_rule" "AllowAllAppTCP" {
  type                     = "ingress"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.DBSecurityGroup.id
  source_security_group_id = aws_security_group.AppSecurityGroup.id
}

# Ports that need to be accessible for external parties

locals {
  DBSecurityGroupPorts = {
    "22" : { "from" : 22, "to" : 22 },
    "4300" : { "from" : 4300, "to" : 4399 },
    "8443" : { "from" : 8443, "to" : 8443 },
    "4237" : { "from" : 4237, "to" : 4237 },
    "8000" : { "from" : 8000, "to" : 8099 },
    "30013" : { "from" : 30013, "to" : 39913 },
    "30015" : { "from" : 30015, "to" : 39915 },
    "30017" : { "from" : 30017, "to" : 39917 },
    "30041" : { "from" : 30041, "to" : 39941 },
    "30044" : { "from" : 30044, "to" : 39944 },
    "50013" : { "from" : 50013, "to" : 59914 }
  }

  DBSecurityGroupUDPforApp = {
    "111" : { "from" : 111, "to" : 111 },
    "2049" : { "from" : 2049, "to" : 2049 },
    "4000" : { "from" : 4000, "to" : 4002 }
  }
}

resource "aws_security_group_rule" "DBSecurityGroupExternalCIDRs" {
  for_each          = length(var.external_cidrs) > 0 ? local.DBSecurityGroupPorts : {}
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = "tcp"
  cidr_blocks       = var.external_cidrs
  security_group_id = aws_security_group.DBSecurityGroup.id
}

resource "aws_security_group_rule" "DBSecurityGroupExternalGroups" {
  for_each          = length(var.external_groups) > 0 ? local.DBSecurityGroupPorts : {}
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = "tcp"
  cidr_blocks       = var.external_groups
  security_group_id = aws_security_group.DBSecurityGroup.id
}

# Some UDP ports have to be accessible by apps for the DB
resource "aws_security_group_rule" "DBSecurityGroupUDPforApp" {
  for_each                 = local.DBSecurityGroupUDPforApp
  type                     = "ingress"
  from_port                = each.value.from
  to_port                  = each.value.to
  protocol                 = "udp"
  source_security_group_id = aws_security_group.AppSecurityGroup.id
  security_group_id        = aws_security_group.DBSecurityGroup.id
}
