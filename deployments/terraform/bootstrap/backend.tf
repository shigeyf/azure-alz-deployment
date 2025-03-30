// backend.tf

terraform {
  backend "local" {
    path = "bootstrap.neu.tfstate"
  }
}
