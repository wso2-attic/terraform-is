#Terraform Resources for WSO2 Identity Server

## Installation

### Prerequisites

* Install and set up [Packer](https://www.packer.io/) (>= v1.4.0 )
* Install and set up [Terraform](https://www.terraform.io/) (>= v0.12.00 )


### Instructions:

1. Download the WSO2  Identity Server terraform resource.

2. Build the Identity Server custom image using centos-base.json packer file 

   **Note:**  If you have an Azure subscription, update user variables in `centos-base.json`  file using your subscription credentials. The WSO2 Identity Server 5.10.0 distribution needs to download into the  `ansible-is/files/packs` directory.

   ```bash
   $ packer build centos-base.json 
   ```

3. Update the build `baseimage` in terraform `variables.tf` file and `terraform.tfvars` maintains the Azure subscription credentials.

   ```bash
   $ terraform apply  
   ```

   **Note:**  Add the host entry `<PUBLIC-IP> is.wso2test.com` in `/etc/hosts` file  to access the WSO2 Identity Server console. 
 
4. Try navigating to the following consoles from your favorite browser.

    **https://is.wso2test.com**
