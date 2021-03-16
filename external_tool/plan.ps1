[CmdletBinding()]
param (

  [Parameter()]
  [ValidateSet("pwsh", "python")]
  [string]$Tool = 'pwsh',

  [Parameter()]
  [int]$USD = 1,

  [Parameter()]
  [int]$ProductId = 1,

  [Parameter()]
  [string]$PlanFileName = 'terraformPlanOutput.bin'
)


terraform plan -var="tool=$Tool" -var="product_id=$ProductId" -var="usd_rate=$USD" -out="$PlanFileName" | Out-Null
terraform show -json "$PlanFileName" | ConvertFrom-Json | Select-Object -ExpandProperty planned_values | Select-Object -ExpandProperty outputs | Select-Object -ExpandProperty data_from_external | Select-Object -ExpandProperty value
Remove-Item $PlanFileName
