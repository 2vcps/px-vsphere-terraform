data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "your datastore"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "pool1" {
   name          = "your RP"
   datacenter_id = data.vsphere_datacenter.dc.id
 }
data "vsphere_network" "public" {
  name          = "your vm network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

#data "vsphere_network" "iscsi" {
#  name          = "iscsi-230"
#  datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}

data "vsphere_virtual_machine" "template" {
  name          = "Ubuntu2004_template_k8s"
  datacenter_id = data.vsphere_datacenter.dc.id
}
