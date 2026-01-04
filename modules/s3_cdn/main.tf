######S3 Bucket######
resource "random_id" "this" {
  byte_length = 4
  }


module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.9.0"
  region = var.aws_region
  bucket = "${var.project_name}-${var.environment}-${var.service}-${random_id.this.hex}"
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true

  versioning = {
    enabled = true
  }

  tags = {
    Project = var.project_name
    Environment = var.environment
  }
}


##########CloudFront OAC################

resource "aws_cloudfront_origin_access_control" "oac" {
  name = "${var.project_name}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

provider "aws" {
  alias  = "use1"
  region = "us-east-1"
}


#############AWS WAF–Rate_Limit_Rule#####################

resource "aws_wafv2_web_acl" "cloudfront_waf" {
  provider = aws.use1

  name  = "${var.project_name}-${var.environment}-waf"
  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name = "RateLimit500Per5Min"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit = 500
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name = "rateLimit500"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name = "${var.project_name}-waf"
    sampled_requests_enabled = true
  }

  tags = {
    Project = var.project_name
    Environment = var.environment
  }
}




##################CloudFront###############
module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "6.0.0"

  enabled = true
  comment = "${var.project_name} CloudFront Distribution"
  default_root_object = "index.html"
  depends_on = [module.s3_bucket]
  web_acl_id = aws_wafv2_web_acl.cloudfront_waf.arn

  origin = {
    s3_origin = {
      domain_name = module.s3_bucket.s3_bucket_bucket_regional_domain_name
      origin_id = "s3-origin"
      origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
      
    }
  }
  default_cache_behavior = {
    target_origin_id = "s3-origin"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress = true
    query_string = true
  }
  ordered_cache_behavior = [
    {
      path_pattern = "/static/*"
      target_origin_id = "s3-origin"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress = true
      query_string = true
    }
  ]
  viewer_certificate = {
    cloudfront_default_certificate = true
  }
  # Custom error pages
  custom_error_response = [
     {
       error_code = 403
       response_code = 200
       response_page_path = "/index.html"
     },
     {
       error_code = 404
       response_code = 200
       response_page_path = "/index.html"
     }
   ]

  tags = {
    Project = var.project_name
    Environment = var.environment
  }
}

#############S3 Bucket Policy (CF OAC)###########################
resource "aws_s3_bucket_policy" "cloudfront_oac_policy" {
  bucket = module.s3_bucket.s3_bucket_id
  depends_on = [module.cloudfront]
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowCloudFrontOAC"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "s3:GetObject"
        Resource = "${module.s3_bucket.s3_bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = module.cloudfront.cloudfront_distribution_arn
          }
        }
      },
      {
        Sid = "DenyInsecureTransport"
        Effect = "Deny"
        Principal = "*"
        Action = "s3:*"
        Resource  = [
          module.s3_bucket.s3_bucket_arn,
          "${module.s3_bucket.s3_bucket_arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
