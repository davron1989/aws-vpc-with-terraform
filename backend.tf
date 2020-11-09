terraform {
  required_version = "0.11.14"

  backend "s3" {
    bucket = "davron-test"
    # dynamodb_table = "test_table"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}