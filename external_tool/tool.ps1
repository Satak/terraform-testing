function ConvertFrom-USD ($USD) {
  $res = Invoke-RestMethod 'https://api.exchangeratesapi.io/latest?base=USD&symbols=EUR'
  ($res.rates.EUR * $USD) -as [int]
}

$input_data = [Console]::In.ReadLine()

$input_json = ConvertFrom-Json $input_data

$rate_in_eur = ConvertFrom-USD $input_json.usd_rate

$output_data = @{
  output_key1 = 'Powershell here #1'
  output_key2 = "Powershell $($input_json.input_param2)"
  output      = "$rate_in_eur EUR"
} | ConvertTo-Json

Write-Output $output_data
