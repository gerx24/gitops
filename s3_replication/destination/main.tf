module "destination_replication_bucket" {
  source = "../module/bucket"

  bucket_name = "gerx24-destination-bucket"
  environment = "dev"
  lifecycle_rules = [
    {
      id      = "Delete files older than 10 days"
      enabled = true
      expiration = {
        days = 10
      }
    }
  ]
}

locals {
  destination_bucket_name = module.destination_replication_bucket.s3_bucket_id
  source_replication_role = "arn:aws:iam::111111111111:role/source-replication-role"
}

resource "aws_s3_bucket_policy" "destination_bucket_replication_policy" {
  bucket = local.destination_bucket_name

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = ""
    Statement = [
      {
        Sid    = "AllowReplicationfromSourceBucket"
        Effect = "Allow"
        Principal = {
          AWS = local.source_replication_role
        }
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags",
          "s3:ObjectOwnerOverrideToBucketOwner",
          "s3:List*",
          "s3:GetBucketVersioning",
          "s3:PutBucketVersioning"
        ]
        Resource = [
          "arn:aws:s3:::${local.destination_bucket_name}/*",
          "arn:aws:s3:::${local.destination_bucket_name}"
        ]
      }
    ]
  })
}
