## ⚡ How to Apply for Dev and Prod
First, select or create workspace in Terraform Cloud:

```
terraform workspace select dev  # or create if doesn't exist
```

 * Then, apply using dev.tfvars:


```terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```
* For Production, switch workspace:


```
terraform workspace select prod  # or create if doesn't exist
```
*  Then apply with prod.tfvars:

``` terraform plan -var-file="prod.tfvars"
    terraform apply -var-file="prod.tfvars"
```