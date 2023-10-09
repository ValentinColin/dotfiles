# Obtient le chemin du répertoire du script
$SCRIPT_DIR = $PSScriptRoot
$POSH_THEME = Join-Path $SCRIPT_DIR "..\config\oh-my-posh\theme\custom.json"
$POSH_THEME = (Get-Item -Path $POSH_THEME ).FullName

# Print the location of the config file
Write-Host "POSH_THEME : $POSH_THEME"

# Add the oh-my-posh invocation in the profile
$POSH_INIT = 'oh-my-posh init pwsh --config ' + "`"$POSH_THEME`"" + ' | Invoke-Expression'
Add-Content -Path $PROFILE -Value $POSH_INIT

# Print the location of the profile script run at each new shell
Write-Host "POSH_THEME now loaded from file : $PROFILE"