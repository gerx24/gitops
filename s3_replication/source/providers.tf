provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      terraform   = "true"
      application = "replication"
      environment = "dev"
    }
  }
}