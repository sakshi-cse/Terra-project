# S3 Bucket Outputs
output "s3_bucket_name" {
  value       = module.s3_bucket.s3_bucket_id
}

output "s3_bucket_arn" {
  value       = module.s3_bucket.s3_bucket_arn
}

output "s3_bucket_regional_domain_name" {
  value       = module.s3_bucket.s3_bucket_bucket_regional_domain_name
}

# CloudFront Outputs
output "cloudfront_distribution_id" {
  value       = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  value       = module.cloudfront.cloudfront_distribution_arn
}

output "cloudfront_domain_name" {
  value       = module.cloudfront.cloudfront_distribution_domain_name
}


##WAF####
output "cloudfront_waf_arn" {

  value       = aws_wafv2_web_acl.cloudfront_waf.arn
}
