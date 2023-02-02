

resource "null_resource" "kube-config" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region us-east-1 --name demo1"
  }
}


resource "kubectl_manifest" "main" {
  yaml_body = file("${path.module}/command.yaml")
depends_on = [
null_resource.kube-config
]
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "sed 's/{{cluster_name}}/'demo1'/;s/{{region_name}}/'us-east-1'/;s/{{http_server_toggle}}/'On'/;s/{{http_server_port}}/'2020'/;s/{{read_from_head}}/'On'/;s/{{read_from_tail}}/'On'/' | kubectl apply -f - "
  }
}

/*resource "null_resource" "example2" {
  provisioner "local-exec" {
    command = "kubectl patch ds fluent-bit -n amazon-cloudwatch --patch-file ./command.yaml"
  }
}*/



