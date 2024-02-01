resource "kubectl_manifest" "karpetner_provisioner" {
  yaml_body = <<YAML
  apiVersion: karpenter.sh/v1alpha5
  kind: Provisioner
  metadata:
    name: karpetner-provisioner
  spec:
    ttlSecondsAfterEmpty: 60 # scale down nodes after 60 seconds without workloads (excluding daemons)
    ttlSecondsUntilExpired: 604800 # expire nodes after 7 days (in seconds) = 7 * 60 * 60 * 24
    limits:
      resources:
        cpu: 100 # limit to 100 CPU cores
    requirements:
      # Include general purpose instance families
      - key: karpenter.k8s.aws/instance-family
        operator: In
        values: [t3]
      # Exclude small instance sizes
      - key: karpenter.k8s.aws/instance-size
        operator: NotIn
        values: [medium]
    providerRef:
      name: karpetner-provisioner
YAML
}

resource "kubectl_manifest" "karpetner_aws_node_template" {
  yaml_body = <<YAML
  apiVersion: karpenter.k8s.aws/v1alpha1
  kind: AWSNodeTemplate
  metadata:
    name: karpetner-provisioner
  spec:
    subnetSelector:
      kubernetes.io/cluster/${var.cluster_name}: owned
    securityGroupSelector:
      kubernetes.io/cluster/${var.cluster_name}: owned
YAML
}
