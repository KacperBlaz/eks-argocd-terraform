resource "kubectl_manifest" "cluster-role" {
  yaml_body = <<YAML
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRole
  metadata:
    name: reader
  rules:
  - apiGroups: ["*"]
    resources: ["deployments", "configmaps", "pods", "secrets", "services"]
    verbs: ["get", "watch", "list"]
YAML
}

resource "kubectl_manifest" "cluster-role-binding" {
  yaml_body = <<YAML
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRoleBinding
  metadata:
    name: reader
  subjects:
  - kind: Group
    name: reader
    apiGroup: rbac.authorization.k8s.io
  roleRef:
    kind: ClusterRole
    name: reader
    apiGroup: rbac.authorization.k8s.io
YAML
}