
$SERVER_INSTANCE = "$(hostname)\CDVI"
$DATABASE = "Centaur3Main"
$OUTPUT_FILE = "$HOME\Desktop\$(Get-Date -UFormat %Y%m%dT%H%M%S).tsv"

function Request-Query {
  param ( 
    [String]$Query,
    [array]$Params,
    [array]$Inputs
  )
  
  if ($Inputs){
    $format = @()
    foreach ($input in $inputs){
      $format += (Invoke-Expression $($input))
      $Query = $Query -f $format

    }
  }

  $results = Invoke-Sqlcmd -ServerInstance $SERVER_INSTANCE -Database $DATABASE -Query $Query
  
  foreach ($result in $results){
    $Display = ""
    $param_counter = 0
    foreach ($param in $Params){
      $Display = $Display + ("{$param_counter}`t" -f $result.$param)
    }
    Write-Host $Display
    Write-Output $Display >> $OUTPUT_FILE
  }
}

$options = Get-Content "options.json" | ConvertFrom-Json

#Display options
foreach($option in $options){
  Write-Host ("[{0}] {1}" -f $option.ID, $option.Description)
}

#User choose option
$OptionChoice = Read-Host -Prompt "Choose an option"

#Retrieve the option
$option = $options | Where-Object { $_.ID -eq $OptionChoice }

#Execute the option
Request-Query $option.Query $option.Params $option.Inputs

Read-Host -Prompt "Press enter to quit..."