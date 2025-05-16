module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.14.1"
  bucket  = var.bucket_name

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  acl = "private"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  versioning = {
    status = "Enabled"
  }

  lifecycle_rule = var.lifecycle_rules

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}
