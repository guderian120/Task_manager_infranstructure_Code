# Placeholder Lambda function code (replace with actual Python code)

resource "aws_lambda_function" "functions" {
  for_each = toset(var.lambda_functions)
  depends_on = [aws_iam_role_policy.lambda_policy]  # Ensure the IAM role policy is created first
  function_name = "${var.project_name}-${each.key}"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  role          =  aws_iam_role.lambda_role.arn  # Use the existing role
  s3_bucket     = "lambdacicdtest0123"
  s3_key        = "lambda-zips/${each.key}.zip"

   tags = {
    Name        = "${var.project_name}-${each.key}"
    Environment = var.environment
  }
}


resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-lambda-role"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.project_name}-lambda-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

