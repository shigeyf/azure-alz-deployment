// local.tf

locals {
  // Resource names
  cmk_name = concat("-", ["cmk", var.key_name_suffix])
}
