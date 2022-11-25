resource "aws_secretsmanager_secret" "sm3" {
  name = "sm3"
}

resource "aws_secretsmanager_secret_version" "sv3" {
  secret_id     = aws_secretsmanager_secret.sm3.id
  secret_string = jsonencode(var.example)
}

output "example" {
  value = jsondecode(aws_secretsmanager_secret_version.sv3.secret_string)["username1"]
  sensitive = true
}
