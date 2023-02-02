/*resource "aws_s3_bucket" "hoge" {
  bucket = "s3bucket-source1"
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.hoge.id
  key    = "test2"
  source = "../../test_results_12-1-2023_16_10.json"
  etag = md5("../../test_results_12-1-2023_16_10.json")
}
resource "aws_athena_database" "hoge" {
  name   = "users"
  bucket = aws_s3_bucket.hoge.id
  #bucket = "s3bucket-source1"
}

resource "aws_athena_named_query" "foo" {
  name      = "bar"
  #workgroup = aws_athena_workgroup.test.id
  database  = "users"
  query     = "CREATE EXTERNAL TABLE test_results(TestInvokeTime timestamp,TestCategory string,TestName string,TestStatus string,TestOutput string) LOCATION 's3://s3bucket-source1/'"
}*/
resource "aws_s3_bucket" "iaac-athena-source-s3bucket" {
  bucket = var.source_bucket_name
}

resource "aws_s3_bucket" "iaac-athena-destination-s3bucket" {
  bucket = var.destination_bucket_name
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.iaac-athena-source-s3bucket.id
  key    = var.key_name
  source = var.object_jsonfile
  etag = md5("../../test_results_12-1-2023_16_10.json")
}
resource "aws_athena_database" "iaac-athena-db" {
  name   = var.athena_database_name
  bucket = aws_s3_bucket.iaac-athena-source-s3bucket.id
  #bucket = "s3bucket-source1"
}

resource "aws_athena_named_query" "iaac-athena-query" {
  name      = var.athena_named_query
  #workgroup = aws_athena_workgroup.example.id
  database  = aws_athena_database.iaac-athena-db.name
  query     = "CREATE EXTERNAL TABLE test_results(TestInvokeTime timestamp,TestCategory string,TestName string,TestStatus string,TestOutput string) ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe' LOCATION 's3://synthetic-athena-bucket-s3/'"
}

/*resource "aws_athena_workgroup" "example" {
  name = "example"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${aws_s3_bucket.iaac-athena-destination-s3bucket.bucket}/output/"
    }
  }
}*/