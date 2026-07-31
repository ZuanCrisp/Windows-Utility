# Runs the development version of winutil

$script = Invoke-RestMethod -Uri https://raw.githubusercontent.com/ZuanCrisp/Windows-Utility/main/winutil.ps1
Invoke-Command -ScriptBlock ([scriptblock]::Create($script)) -ErrorAction Stop
