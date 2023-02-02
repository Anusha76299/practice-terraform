variable "source_bucket_name" {
  type    = string
  default = "synthetic-monitoring-results420"
}
variable "destination_bucket_name" {
  type    = string
  default = "synthetic-athena-bucket-420"
}
variable "key_name" {
  type    = string
  default = "test2"
}
variable "object_jsonfile" {
  type    = string
  default = "../../test_results.json"
}
variable "athena_database_name" {
  type    = string
  default = "syntheticdb420"
}
variable "athena_named_query" {
  type    = string
  default = "data"
}
/*variable "athena_named_query_database" {
  type    = string
  default = "CREATE EXTERNAL TABLE test_results(TestInvokeTime timestamp,TestCategory string,TestName string,TestStatus string,TestOutput string) ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe' LOCATION 's3://synthetic-monitoring-results420/'"
}*/
