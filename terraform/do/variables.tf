variable "do_token" {
  type        = string
  description = "Your DigitalOcean API token. See https://cloud.digitalocean.com/account/api/tokens to generate a token."
}

variable ssh_key_file {
  type        = string
  description = "The private ssh certificate in the user's .ssh/ dir -> $HOME/.ssh/id_rsa. Terrform uses this to access & run commands on node."
}

variable do_ssh_key {
  type        = string
  default     = "ariv3ra-ssh"
  description = "Specifies a Public SSH cert that exists in the DO Account Security section. See https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys/to-account/"
}

variable file_agent_install {
  type        = string
  default     = "../../runner-scripts/runner-agent-install"
  description = "Specifies the runner-agent-install script file path"
}

variable file_provisioner {
  type        = string
  default     = "../../runner-scripts/runner-provisioner"
  description = "Specifies the runner-provisioner script file path"
}

variable runner_platform {
  type        = string
  default     = "linux/amd64"
  description = "Defines the runner architecture platform choose one: [linux/amd64, linux/arm64, darwin/amd64]"
}

variable runner_name {
  type        = string
  description = "The host name of the CircleCI Runner which is also the Droplet name."
}

variable runner_token {
  type        = string
  description = "The CircleCI Runner token from the CLI"
}

variable "region" {
  type        = string
  description = "The region where the assets should be assigned to"
  default     = "nyc3"
}

variable "node_size" {
  type        = string
  description = "defines the size of the compute node"
  default     = "s-4vcpu-8gb"
}

variable "image_name" {
  type        = string
  description = "defines the DigitalOcean image name to install to compute node"
  default     = "ubuntu-20-04-x64"
}

variable droplet_count {
  type        = number
  default     = 2
  description = "The number of Droplet nodes you want to create"
}
