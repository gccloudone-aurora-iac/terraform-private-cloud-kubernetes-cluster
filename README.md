# terraform-private-cloud-kubernetes-cluster

This module deploys a Kubernetes cluster via Rancher in GC Private Cloud.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_rancher2"></a> [rancher2](#requirement\_rancher2) | ~> 8.2 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_rancher2"></a> [rancher2](#provider\_rancher2) | ~> 8.2 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [rancher2_cloud_credential.this](https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cloud_credential) | resource |
| [rancher2_cluster_v2.this](https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_v2) | resource |
| [rancher2_machine_config_v2.this](https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/machine_config_v2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_additional_pools"></a> [additional\_pools](#input\_additional\_pools) | List of pools for the cluster. | <pre>list(object({<br/>    name    = string<br/>    roles   = optional(list(string), ["worker"])<br/>    flavour = optional(string, "g4v-16")<br/>    count   = optional(number, 1)<br/>    labels  = optional(map(string))<br/>    taints = optional(list(object({<br/>      key    = string<br/>      value  = string<br/>      effect = optional(string, "NoExecute")<br/>    })), [])<br/>    security_groups = optional(list(string), ["default"])<br/>    volume_type     = optional(string, "performance")<br/>    volume_size     = optional(number, 60)<br/>    image_name      = optional(string)<br/>    user_data       = optional(string)<br/>    network_id      = optional(string)<br/>    subnet_id       = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_cluster_cidr"></a> [cluster\_cidr](#input\_cluster\_cidr) | CIDRs used for Kubernetes pods. | `list(string)` | <pre>[<br/>  "192.168.0.0/16"<br/>]</pre> | no |
| <a name="input_control_pool"></a> [control\_pool](#input\_control\_pool) | Configuration for the control pool. | <pre>object({<br/>    name    = optional(string, "control")<br/>    flavour = optional(string, "g4v-16")<br/>    count   = optional(number, 1)<br/>    labels  = optional(map(string))<br/>    taints = optional(list(object({<br/>      key    = string<br/>      value  = string<br/>      effect = optional(string, "NoExecute")<br/>    })), [])<br/>    security_groups = optional(list(string), ["default"])<br/>    volume_type     = optional(string, "performance")<br/>    volume_size     = optional(number, 60)<br/>    roles           = optional(list(string), ["etcd", "control"])<br/>    image_name      = optional(string)<br/>    user_data       = optional(string)<br/>    network_id      = optional(string)<br/>    subnet_id       = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_force_internal_loadbalancers"></a> [force\_internal\_loadbalancers](#input\_force\_internal\_loadbalancers) | If true, only internal load balancers may be used. | `bool` | `false` | no |
| <a name="input_global_registry"></a> [global\_registry](#input\_global\_registry) | Global registry for system resources. | `string` | `"docker.io"` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Name of the image for the nodes. | `string` | `"Debian 12"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of Kubernetes to install. | `any` | n/a | yes |
| <a name="input_loadbalancer_network_id"></a> [loadbalancer\_network\_id](#input\_loadbalancer\_network\_id) | The ID of the network that LoadBalancers will exist in. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the cluster. | `any` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | Network ID of the OpenStack network where to deploy the cluster. | `any` | n/a | yes |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin to use for the cluster. | `string` | `"cilium"` | no |
| <a name="input_openstack_application_credential_id"></a> [openstack\_application\_credential\_id](#input\_openstack\_application\_credential\_id) | Application Credential ID used by Rancher to provision on OpenStack. | `any` | n/a | yes |
| <a name="input_openstack_application_credential_secret"></a> [openstack\_application\_credential\_secret](#input\_openstack\_application\_credential\_secret) | Application Credential Secret used by Rancher to provision on OpenStack. | `any` | n/a | yes |
| <a name="input_openstack_auth_url"></a> [openstack\_auth\_url](#input\_openstack\_auth\_url) | OpenStack Authentication URL | `any` | n/a | yes |
| <a name="input_openstack_availability_zone"></a> [openstack\_availability\_zone](#input\_openstack\_availability\_zone) | OpenStack Availability Zone where to deploy the cluster. | `any` | `null` | no |
| <a name="input_openstack_domain_id"></a> [openstack\_domain\_id](#input\_openstack\_domain\_id) | Domain ID of the OpenStack tenant where to deploy the cluster.. | `any` | n/a | yes |
| <a name="input_openstack_project_id"></a> [openstack\_project\_id](#input\_openstack\_project\_id) | Project ID of the OpenStack project where to deploy the cluster. | `any` | n/a | yes |
| <a name="input_openstack_region"></a> [openstack\_region](#input\_openstack\_region) | OpenStack region where to deploy the cluster. | `any` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | CIDRs used for Kubernetes services. | `list(string)` | <pre>[<br/>  "172.16.0.0/20"<br/>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the OpenStack resources | `map(string)` | `{}` | no |
| <a name="input_worker_pool"></a> [worker\_pool](#input\_worker\_pool) | Configuration for the worker pool. | <pre>object({<br/>    name    = optional(string, "worker")<br/>    flavour = optional(string, "g4v-16")<br/>    count   = optional(number, 1)<br/>    labels  = optional(map(string))<br/>    taints = optional(list(object({<br/>      key    = string<br/>      value  = string<br/>      effect = optional(string, "NoExecute")<br/>    })), [])<br/>    security_groups = optional(list(string), ["default"])<br/>    volume_type     = optional(string, "performance")<br/>    volume_size     = optional(number, 60)<br/>    roles           = optional(list(string), ["worker"])<br/>    image_name      = optional(string)<br/>    user_data       = optional(string)<br/>    network_id      = optional(string)<br/>    subnet_id       = optional(string)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_cluster_v1_id"></a> [cluster\_v1\_id](#output\_cluster\_v1\_id) | The v1 compatible ID of the new Rancher cluster. |
<!-- END_TF_DOCS -->
