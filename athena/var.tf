variable "source_bucket_name" {
  type = string
  default = "synthetic-monitoring-results-s3"
}

variable "destination_bucket_name" {
  type = string
  default = "synthetic-athena-bucket-s3"
}

variable "key_name" {
 type = string
 default = "test2" 
}

variable "object_jsonfile" {
  type = string
  default = "../../test_results_12-1-2023_16_10.json"
}
variable "athena_database_name" {
  type = string
  default = "users3"
}

variable "athena_named_query" {
  type = string
  default = "data1"
}

variable "athena_named_database" {
    type = string
    default = "users3"
  
}

/*variable "athena_named_query_database" {
  type = string
  default = "CREATE EXTERNAL TABLE test_result(TestInvokeTime timestamp,TestCategory string,TestName string,TestStatus string,TestOutput string) ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe' LOCATION 's3://synthetic-athena-bucket-s3/'"
}*/