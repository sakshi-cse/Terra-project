################ S3 Bucket ################
output "s3_bucket_id" {
  value = module.s3_bucket.s3_bucket_id
}

output "s3_bucket_arn" {
  value = module.s3_bucket.s3_bucket_arn
}

output "s3_bucket_bucket_domain_name" {
  value = module.s3_bucket.s3_bucket_bucket_domain_name
}

############### CloudFront ################
output "cloudfront_distribution_id" {
  value = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  value = module.cloudfront.cloudfront_distribution_arn
}

output "cloudfront_distribution_domain_name" {
  value = module.cloudfront.cloudfront_distribution_domain_name

}
