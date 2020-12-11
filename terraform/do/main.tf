terraform {

  required_version = ">= 0.13"

  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  # This backend uses the terraform cloud for state.
  backend "remote" {
    organization = "datapunks"
    workspaces {
      name = "dorunner"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = var.do_ssh_key
}

resource "digitalocean_droplet" "dorunner" {
  count              = var.droplet_count
  image              = var.image_name
  name               = "${var.runner_name}-${count.index}"
  region             = var.region
  size               = var.node_size
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.ssh_key_file)
    timeout     = "3m"
  }

  #Upload runner agent install script
  provisioner "file" {
    source      = var.file_agent_install
    destination = "/tmp/runner-agent-install"
  }

  #Upload runner provisioner script
  provisioner "file" {
    source      = var.file_provisioner
    destination = "/tmp/runner-provisioner"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      "sudo apt -y upgrade",
      "curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -",
      "sudo apt install -y nodejs",
      "cd /tmp",
      "chmod +x /tmp/runner-agent-install",
      "chmod +x /tmp/runner-provisioner",
      "/tmp/runner-agent-install ${var.runner_platform}",
      "/tmp/runner-provisioner ${var.runner_platform} ${var.runner_name} ${var.runner_token}",
    ]
  }
}

output "runner_hosts_and_ip_addresses" {
  value = {
    for instance in digitalocean_droplet.dorunner:
    instance.name => instance.ipv4_address
  }
}

