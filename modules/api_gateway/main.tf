resource "aws_api_gateway_rest_api" "api" {
  name        = "${var.project_name}-api"
  description = "API Gateway for ${var.project_name} Lambda functions"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = {
    Name        = "${var.project_name}-api"
    Environment = var.environment
  }
}

resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name                   = "${var.project_name}-cognito-authorizer"
  rest_api_id            = aws_api_gateway_rest_api.api.id
  identity_source        = "method.request.header.Authorization"
  type                   = "COGNITO_USER_POOLS"
  provider_arns          = [var.user_pool_arn]
}

resource "aws_api_gateway_resource" "resources" {
  for_each = var.lambda_functions

  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = each.key
}




# Add OPTIONS method for each resource to handle preflight
resource "aws_api_gateway_method" "options_method" {
  for_each = var.lambda_functions

  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resources[each.key].id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

# Add integration for OPTIONS method
resource "aws_api_gateway_integration" "options_integration" {
  for_each = var.lambda_functions

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resources[each.key].id
  http_method = aws_api_gateway_method.options_method[each.key].http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

# Add method response for OPTIONS
resource "aws_api_gateway_method_response" "options_response" {
  for_each = var.lambda_functions

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resources[each.key].id
  http_method = aws_api_gateway_method.options_method[each.key].http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  response_models = {
    "application/json" = "Empty"
  }
}

# Add integration response for OPTIONS
resource "aws_api_gateway_integration_response" "options_integration_response" {
  for_each = var.lambda_functions

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resources[each.key].id
  http_method = aws_api_gateway_method.options_method[each.key].http_method
  status_code = aws_api_gateway_method_response.options_response[each.key].status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT,DELETE'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [aws_api_gateway_integration.options_integration]
}

# Add CORS headers to your existing methods
resource "aws_api_gateway_method_response" "method_response" {
  for_each = var.lambda_functions

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resources[each.key].id
  http_method = aws_api_gateway_method.methods[each.key].http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}


resource "aws_api_gateway_integration_response" "integration_response" {
  for_each = var.lambda_functions

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resources[each.key].id
  http_method = aws_api_gateway_method.methods[each.key].http_method
  status_code = aws_api_gateway_method_response.method_response[each.key].status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [aws_api_gateway_integration.integrations]
}



resource "aws_api_gateway_method" "methods" {
  for_each = var.lambda_functions

  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resources[each.key].id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "integrations" {
  for_each = var.lambda_functions

  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resources[each.key].id
  http_method             = aws_api_gateway_method.methods[each.key].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${each.value}/invocations"
}

resource "aws_lambda_permission" "api_gateway" {
  for_each = var.lambda_functions

  statement_id  = "AllowAPIGatewayInvoke-${each.key}"
  action        = "lambda:InvokeFunction"
  function_name =  each.value
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/${each.key}"
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  depends_on = [
    aws_api_gateway_integration.integrations
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
  stage_name    = var.environment

  tags = {
    Name        = "${var.project_name}-stage"
    Environment = var.environment
  }
}