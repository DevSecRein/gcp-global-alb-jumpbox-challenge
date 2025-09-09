# RDP Jumpbox

The goal of this project is to create three private webservers in different zones that is only accessible via an RDP jumpbox.

GCP does not have private and public subnets in the same sense as AWS. The designation does not exist in GCP. In GCP you must create a subnet then make it private by limiting its resources's internet exposure. To accomplish this you must first make sure that VMs do not have a public internet address. You can either comment out or delete the part of the network interface terraform code relating to access config.

```
network_interface {
    subnetwork = google_compute_subnetwork.private-subnet.id
    # access_config {
    #   # Include this section to give the VM an external IP address
    # }
  }

```

The section of code above will either be found where the VMs or the VM template is coded.

To assure private via the RDP jumpbox, one needs to master GCP's tagging system. In the section of code dedicated to firewalls, you should see both "source_tags" and "target_tags" labels. Target tags tells the code to apply a firewall policy to any resource tagged with the target tag. Source tags tells the code to only accept a connection from a resource tagged with the source tag.

In this case the webservers are tagged "private_webserver" and the windows machine to be used as a jumpbox is tagged "rdp_access". Likewise the ssh, http, and https firewall policies all have a target tag of "private-webserver", that way the webservers allow the three methods of access. And those three firewall policies all have "rdp-access" as a source tag. This makes it so they will only allow ssh, http, and https from a resource with the "rdp_access" source tag, which is then given to the rdp jumpbox.


# Proof of Concept

Below are screenshots to prove that everything works correctly

The Firewall Rules:
![Screenshot](/readme_images/Screen%20Shot%202025-09-08%20at%2020.43.47)

The VM instancees:
![Screenshot](/readme_images/Screen%20Shot%202025-09-08%20at%2020.45.05)

Note that there are no external IP addresses to the webservers. If the internal IP addresses are used outside of a GCP resource in the same VPC, it will just time out. And thanks to the source tag policy, even in the same VPC, if a resource is spun up and does not have the source tag, it will also result in an error.

Also note that the firewall policies have only been given to to resources tagged with the policies source tag and is filtered by the source tag

But once the webservers are accessed from the the rdp jumpbox, they are fully accessible:
![Screenshot](/readme_images/Screen%20Shot%202025-09-08%20at%2020.54.31%20(2))
![Screenshot](/readme_images/Screen%20Shot%202025-09-08%20at%2020.56.09%20(2))
![Screenshot](/readme_images/Screen%20Shot%202025-09-08%20at%2020.59.15%20(2))
