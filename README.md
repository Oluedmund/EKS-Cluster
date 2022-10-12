# Self manage eks cluster

This terraform code is used to provision 3 self managed worker nodes[eks] but can be extended to more than 3

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on aws.

### Prerequisites

Generate "ACCESS KEY AND SECRET KEY" on aws

```
Terraform will use the access and secret keys to authenticate to aws
```

### Installing

Make sure to install the following

```
Terraform, AWS CLI, and kubectl installed
```

## Running the code

Open a terminal and run the following command to add the access and secrete key

```
aws configure
```
Clone the repo

```
git clone [repo url]
```

Change directory into the repo

```
cd terraform-eks
```

Create a file name terraform.tfvars

```
touch terraform.tfvars
```

Declare the following values in the terraform.tfvars

```
vpc_cidr_block = "" # example 10.0.0.0/16 
private_subnet_cidr_blocks = ["", "", ""] # 3 private subnet block
public_subnet_cidr_blocks = ["", "", ""]  # 3 public subnet block
```

## Deployment
Save the above terraform.tfvars, open the terminal and run the following command

```
terraform init 
terraform plan 
terraform apply -auto-approve
```

Run the following command to create the kubeconfig file and set the region to eu-west-2 (you can choose any region), "myapp-eks-cluster" is the name of the cluster

```
aws eks update-kubeconfig --name myapp-eks-cluster --region eu-west-2
```

## Built With

* https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
* https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/17.24.0  


## Acknowledgments

* Journey to DevOps/SRE 

