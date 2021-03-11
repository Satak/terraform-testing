# Terraform External Tool

`external` is a special provider that exists to provide an interface between Terraform and external programs. In this example Terraform will call either Python or Powershell depending on the input variable `tool`. Data communication (input and output) between external tool and Terraform is `JSON` and it uses `stdin` and `stdout`. JSON value must be in string format.

## Official documentation

<https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source>

## Terraform `main.tf`

Simple example:

```hcl
data "external" "my_data" {
  program = ["python", "${path.module}/tool.py"]

  query = {
    input_param1 = "input #1 for script"
    input_param2 = "input #2 for script"
  }
}

output "data_from_external" {
  value = data.external.my_data.result.output
}
```

## Python

Python script gets data from the local `db.json` file by the input variable `product_id`.

## Powershell

Powershell script fetches data from `https://api.exchangeratesapi.io` API and gets the conversion rate between USD and EUR. Input variable `usd_rate`.

## Run plan examples

```bash
# python: fetches product from db.json local file by input param product_id
terraform plan -var="tool=python" -var="product_id=3"
# -> data_from_external = "Coffee"

# powershell: fetches rate (api call) between USD and EUR by input param usd_rate
terraform plan -var="tool=powershell" -var="usd_rate=500"
# -> data_from_external = "420 EUR"
```
