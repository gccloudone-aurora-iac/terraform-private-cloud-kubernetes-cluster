###########################
### OpenStack Resources ###
###########################

variable "openstack_application_credential_id" {
  description = "Application Credential ID used by Rancher to provision on OpenStack."
}

variable "openstack_application_credential_secret" {
  description = "Application Credential Secret used by Rancher to provision on OpenStack."

  sensitive = true
}

variable "openstack_domain_id" {
  description = "Domain ID of the OpenStack tenant where to deploy the cluster.."
}

variable "openstack_project_id" {
  description = "Project ID of the OpenStack project where to deploy the cluster."
}

variable "openstack_auth_url" {
  description = "OpenStack Authentication URL"
}

variable "openstack_region" {
  description = "OpenStack region where to deploy the cluster."
}

variable "openstack_availability_zone" {
  description = "OpenStack Availability Zone where to deploy the cluster."

  default = null
}

variable "tags" {
  description = "Tags to assign to the OpenStack resources"
  type        = map(string)
  default     = {}
}

###########################
### Rancher Resources ###
###########################

variable "name" {
  description = "Name of the cluster."
}

variable "network_id" {
  description = "Network ID of the OpenStack network where to deploy the cluster."
}

variable "image_name" {
  description = "Name of the image for the nodes."

  default = "Debian 12"
}

variable "kubernetes_version" {
  description = "Version of Kubernetes to install."
}

variable "global_registry" {
  description = "Global registry for system resources."

  default = "docker.io"
}

variable "network_plugin" {
  description = "Network plugin to use for the cluster."

  default = "cilium"

  validation {
    condition     = contains(["none", "cilium"], var.network_plugin)
    error_message = "Valid network plugins are: none, cilium"
  }
}

variable "cluster_cidr" {
  description = "CIDRs used for Kubernetes pods."

  type    = list(string)
  default = ["192.168.0.0/16"]
}

variable "service_cidr" {
  description = "CIDRs used for Kubernetes services."

  type    = list(string)
  default = ["172.16.0.0/20"]
}

variable "control_pool" {
  description = "Configuration for the control pool."

  type = object({
    name    = optional(string, "control")
    flavour = optional(string, "g4v-16")
    count   = optional(number, 1)
    labels  = optional(map(string))
    taints = optional(list(object({
      key    = string
      value  = string
      effect = optional(string, "NoExecute")
    })), [])
    security_groups = optional(list(string), ["default"])
    volume_type     = optional(string, "performance")
    volume_size     = optional(number, 60)
    roles           = optional(list(string), ["etcd", "control"])
    image_name      = optional(string)
    user_data       = optional(string)
    network_id      = optional(string)
    subnet_id       = optional(string)
  })

  default = {}
}

variable "worker_pool" {
  description = "Configuration for the worker pool."

  type = object({
    name    = optional(string, "worker")
    flavour = optional(string, "g4v-16")
    count   = optional(number, 1)
    labels  = optional(map(string))
    taints = optional(list(object({
      key    = string
      value  = string
      effect = optional(string, "NoExecute")
    })), [])
    security_groups = optional(list(string), ["default"])
    volume_type     = optional(string, "performance")
    volume_size     = optional(number, 60)
    roles           = optional(list(string), ["worker"])
    image_name      = optional(string)
    user_data       = optional(string)
    network_id      = optional(string)
    subnet_id       = optional(string)
  })

  default = {}
}

variable "additional_pools" {
  description = "List of pools for the cluster."

  type = list(object({
    name    = string
    roles   = optional(list(string), ["worker"])
    flavour = optional(string, "g4v-16")
    count   = optional(number, 1)
    labels  = optional(map(string))
    taints = optional(list(object({
      key    = string
      value  = string
      effect = optional(string, "NoExecute")
    })), [])
    security_groups = optional(list(string), ["default"])
    volume_type     = optional(string, "performance")
    volume_size     = optional(number, 60)
    image_name      = optional(string)
    user_data       = optional(string)
    network_id      = optional(string)
    subnet_id       = optional(string)
  }))

  default = []
}

variable "loadbalancer_network_id" {
  type        = string
  description = "The ID of the network that LoadBalancers will exist in."
}

variable "force_internal_loadbalancers" {
  type        = bool
  description = "If true, only internal load balancers may be used."
  default     = false
}
