resource "aws_iam_role" "demo_lambda_role" {
  name = "demo-lambda-role-${var.change}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}  
EOF
}
data "archive_file" "lambda" {
  type        = "zip"
  output_path = "${path.root}/.archive_files/lambda.zip"

  # fingerprinter
  source {
    filename = "index.js"
    content  = <<CODE
exports.handler = async (event) => { console.log('test!'); };
CODE
  }
}

resource "aws_lambda_function" "function" {
  count = 100
  package_type = "Zip"
  function_name = "demo-${var.change}-${random_id.id.hex}-${count.index}"
  handler	= "index.handler"
  runtime       = "nodejs12.x"
  role          = aws_iam_role.demo_lambda_role.arn
  timeout       = 60

  memory_size   = 128
  filename         = "${data.archive_file.lambda.output_path}"
  source_code_hash = "${data.archive_file.lambda.output_base64sha256}"
  
}