module "source_replication_bucket" {
  source = "../module/bucket"
  environment        = "dev"
  bucket_name        = "gerx24-source-bucket"
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
  source_replication_bucket_arn  = module.source_replication_bucket.s3_bucket_id
  bucket_name                    = module.source_replication_bucket.s3_bucket_arn
  destination_bucket_arn         = "arn:aws:s3:::gerx24-destination-bucket"
  source_replication_policy_name = "source-replication-policy"
  source_replication_role_name   = "source-replication-role"


  common_tags = {
    environment = "dev"
    maintainer  = "gerx24"
  }
}

resource "aws_iam_role" "replication_role" {
  name = local.source_replication_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "s3.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_policy" "replication_policy" {
  name = local.source_replication_policy_name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetReplicationConfiguration",
          "s3:ListBucket"
        ],
        Resource = [
          "${local.source_replication_bucket_arn}/*",
          "${local.source_replication_bucket_arn}",
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging"
        ],
        Resource = [
          "${local.source_replication_bucket_arn}/*",
          "${local.source_replication_bucket_arn}"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags",
          "s3:ObjectOwnerOverrideToBucketOwner"
        ],
        Resource = [
          "${local.destination_bucket_arn}/*",
          "${local.destination_bucket_arn}"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication_role.name
  policy_arn = aws_iam_policy.replication_policy.arn
}

resource "aws_s3_bucket_replication_configuration" "replication_bucket_config" {
  depends_on = [module.source_replication_bucket]

  role   = aws_iam_role.replication_role.arn
  bucket = local.bucket_name

  rule {
    id = "cross-replication"
    delete_marker_replication {
      status = "Disabled"
    }
    source_selection_criteria {
      replica_modifications {
        status = "Enabled"
      }

    }
    filter {
      prefix = ""
    }

    status = "Enabled"

    destination {
      bucket        = local.destination_bucket_arn
      storage_class = "STANDARD"
      access_control_translation {
        owner = "Destination"
      }
      account = "222222222222"

      metrics {
        status = "Enabled"

        event_threshold {
          minutes = 15
        }
      }
      replication_time {
        status = "Enabled"

        time {
          minutes = 15
        }
      }
    }
  }
}