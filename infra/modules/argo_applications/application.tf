data "kubectl_file_documents" "argotest" {
  content = file("./applications/argo-test.yaml")
}

resource "kubectl_manifest" "argo_test_app" {
  count = length(data.kubectl_file_documents.argotest.manifests)
  yaml_body = element(data.kubectl_file_documents.argotest, count.index )
}