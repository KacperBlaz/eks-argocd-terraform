resource "kubectl_manifest" "configmap" {
  yaml_body = <<YAML
#  yaml_body = yamlencode({
  apiVersion: v1
  data:
    mapUsers: |
      - userarn: arn:aws:iam::410040632229:user/developer
        username: developer
        groups:
          - reader
    mapRoles: |
      - groups:
        - system:bootstrappers
        - system:nodes
        rolearn: arn:aws:iam::410040632229:role/eks_node_group_role-dev
        username: system:node:{{EC2PrivateDNSName}}
  kind: ConfigMap
  metadata:
    name: aws-auth
    namespace: kube-system
YAML
}
#})
