resource "null_resource" "kubeconfig" {
    provisioner "local-exec" {
      command = "aws eks update-kubeconfig --region us-east-1 --name demo"
    }
  
}


resource "kubectl_manifest" "pod" {
  yaml_body = file("${path.module}/components.yaml")
  depends_on = [
    null_resource.kubeconfig
  ]
}

resource "null_resource" "matrices" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml"
  }
  provisioner "local-exec" {
    command = "kubectl get deployment metrics-server -n kube-system"
    
  }
}