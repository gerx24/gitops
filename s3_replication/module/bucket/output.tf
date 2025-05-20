output "s3_bucket_id" {
  description = "Bucket ID"
  value       = module.s3_bucket.s3_bucket_id
}
output "s3_bucket_arn" {
  description = "Bucket ARN"
  value       = module.s3_bucket.s3_bucket_arn
}
