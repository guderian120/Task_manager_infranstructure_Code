module "s3" {
  source        = "./modules/s3"
  bucket_name   = var.s3_bucket_name
  project_name  = var.project_name
  environment   = var.environment
}

module "cloudfront" {
  source           = "./modules/cloudfront"
  bucket_name      = module.s3.bucket_name
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  project_name     = var.project_name
  environment      = var.environment
}

module "cognito" {
  source               = "./modules/cognito"
  user_pool_name       = var.cognito_user_pool_name
  project_name         = var.project_name
  environment          = var.environment
  cloudfront_domain    = module.cloudfront.domain_name
}

# module "amplify" {
#   source               = "./modules/amplify"
#   project_name         = var.project_name
#   user_pool_id         = module.cognito.user_pool_id
#   user_pool_client_id  = module.cognito.user_pool_client_id
#   environment          = var.environment
# }

module "lambda" {
  source           = "./modules/lambda"
  lambda_functions = var.lambda_functions
  project_name     = var.project_name
  environment      = var.environment
}

module "api_gateway" {
  source               = "./modules/api_gateway"
  lambda_functions     = module.lambda.lambda_functions
  user_pool_arn        = module.cognito.user_pool_arn
  project_name         = var.project_name
  environment          = var.environment
  region              =  var.region  
}