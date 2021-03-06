[CmdletBinding()]
param (

  [Parameter()]
  [ValidateSet("powershell", "python")]
  [string]$Tool = 'powershell',

  [Parameter()]
  [int]$USD = 1,

  [Parameter()]
  [int]$ProductId = 1,

  [Parameter()]
  [string]$ClientId = '93c12eb5-cbe9-4df1-975e-30c4ea871906',

  [Parameter()]
  [string]$PlanFileName = 'terraformPlanOutput.bin'
)

terraform plan -var="tool=$Tool" -var="product_id=$ProductId" -var="client_id=$ClientId" -var="usd_rate=$USD" -out="$PlanFileName" | Out-Null
terraform show -json "$PlanFileName" | ConvertFrom-Json | Select-Object -ExpandProperty planned_values | Select-Object -ExpandProperty outputs | Select-Object -ExpandProperty data_from_external | Select-Object -ExpandProperty value
Remove-Item $PlanFileName
