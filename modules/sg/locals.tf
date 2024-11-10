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