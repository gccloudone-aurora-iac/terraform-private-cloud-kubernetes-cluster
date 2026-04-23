output "cluster_v1_id" {
  description = "The v1 compatible ID of the new Rancher cluster."
  value       = rancher2_cluster_v2.this.cluster_v1_id
}
