resource "aws_s3_bucket" "iaac-athena-source-s3bucket" {
  bucket = var.source_bucket_name
}

resource "aws_s3_bucket" "iaac-athena-destination-s3bucket" {
  bucket = var.destination_bucket_name
}

resource "aws_s3_object" "object" {
  bucket = var.source_bucket_name
  key    = var.key_name
  source = var.object_jsonfile
  etag   = md5("../../test_results.json")
}
resource "aws_athena_database" "iaac-athena-db" {
  name = var.athena_database_name
  #bucket = aws_s3_bucket.iaac-athena-source-s3bucket.id
  bucket = var.source_bucket_name
}
resource "aws_athena_workgroup" "athena_workgroup" {
  name = "synthetic-monitoring-workgroup"

  configuration {
    #enforce_workgroup_configuration    = true
    #publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${var.destination_bucket_name}/output/"
    }
  }
}
resource "aws_athena_named_query" "iaac-athena-query" {
  name      = var.athena_named_query
  workgroup = aws_athena_workgroup.athena_workgroup.id
  database  = aws_athena_database.iaac-athena-db.name
  #query    = var.athena_named_query_database
  query = "CREATE EXTERNAL TABLE test_results(TestInvokeTime timestamp,TestCategory string,TestName string,TestStatus string,TestOutput string) ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe' LOCATION 's3://${var.source_bucket_name}/'"
}
