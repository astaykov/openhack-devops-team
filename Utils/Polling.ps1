<#

.SYNOPSIS
    Healthcheck the Uri and display the result.

.DESCRIPTION
    The polling.ps1 display the helthcheck result for each second. You will see the format
    [Timestamp] | [StatusCode] | [Uri]

.PARAMETER Uri
    The target uri for checking the status

.PARAMETER displayUri
    If $true, it displays the Uri in output

.EXAMPLE
PS > .\polling.ps1 -Uri https://github.com/Azure-Samples/openhack-devops-proctor -displayUri $true
.\polling.ps1 -Uri https://github.com/Azure-Samples/openhack-devops-proctor -displayUri $true
21/03/2019 14:21:17 | 200 | https://github.com/Azure-Samples/openhack-devops-proctor
21/03/2019 14:21:21 | 200 | https://github.com/Azure-Samples/openhack-devops-proctor

.EXAMPLE
PS > .\polling.ps1 -Uri https://github.com/Azure-Samples/openhack-devops-proctor
21/03/2019 14:21:55 | 200
21/03/2019 14:21:58 | 200

#>

Param(
    [string] [Parameter(Mandatory=$true)] $Uri,
    [boolean] [Parameter(Mandatory=$false)] $displayUri,
    [int] [Parameter(Mandatory=$false)] $timeoutInSeconds = 60
    )

$timer = 0

while($true) {
try{
      $R = Invoke-WebRequest -URI $Uri
      $timestamp = Get-Date
      $output = ""
      if ($displayUri) {
        $output = '{0} | {1} | {2} | {3}' -f($timestamp, $R.StatusCode, $Uri, $R.Content)
    
      } else {

        $output = '{0} | {1}' -f($timestamp, $R.StatusCode)
      }
      $statusJson = $R.Content | ConvertFrom-Json
      if($statusJson.status -eq "healthy")
      {
        exit 0
      }
}
catch [System.SystemException] {
    $output = "Could not query web site, maybe down!"
}
      Write-Output $output
      Start-Sleep -Seconds 1
      $timer = $timer + 1
      if($timer -ge $timeoutInSeconds)
      {
        exit 1
      }
}