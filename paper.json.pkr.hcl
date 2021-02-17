# This file was autogenerated by the BETA 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/from-1.5/variables#type-constraints for more info.
# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

variable "tag" {
  type = string
  default = "0-0-0"
}
# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/from-1.5/blocks/source
source "googlecompute" "autogenerated_1" {
  disk_size           = 20
  disk_type           = "pd-ssd"
  image_description   = "paper-mc image"
  image_family        = "serena-minecraft"
  image_name          = "paper-mc-${var.tag}"
  project_id          = "telvanni-platform"
  source_image_family = "tel-base-debian-10"
  ssh_username        = "packer"
  zone                = "us-central1-a"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/from-1.5/blocks/build
build {
  sources = ["source.googlecompute.autogenerated_1"]

  provisioner "file" {
    destination = "/tmp/paper.deb"
    source      = "./paper.deb"
  }
  provisioner "file" {
    destination = "/tmp/dbus-api.deb"
    source      = "./dbus-api.deb"
  }
  provisioner "ansible-local" {
    extra_arguments = ["--extra-vars", "ansible_python_interpreter=/usr/bin/python3"]
    playbook_file   = "paper-install.yaml"
  }
}
