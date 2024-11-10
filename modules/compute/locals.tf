locals {
  Owner      = "Prod-Team"
  costcenter = "Hyd-Team"
  TeamDL     = "nithinkumar@google.com"
}

locals {
  common_tags = {
    Owner      = "${local.Owner}"
    costcenter = "${local.costcenter}"
    TeamDL     = "${local.TeamDL}"
  }
}

# tags = {
#   Name        = "${var.vpc_name}-public-route-table"
#   Owner       = locals.Owner
#   costcenter  = locals.costcenter
#   TeamDL      = locals.TeamDL
#   environment = "${var.environment}"
# }
