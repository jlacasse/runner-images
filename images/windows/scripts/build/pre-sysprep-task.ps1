$Path = 'HKLM:\Software\Microsoft\Windows Advanced Threat Protection'
$Name = 'senseGuid'
try {
    Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop
    Remove-ItemProperty -Path $Path -Name $Name -Force -ErrorAction Stop
}
catch {
    Write-Warning "$_.Exception.Message" -WarningAction SilentlyContinue
}

$Path = 'HKLM:\Software\Microsoft\Windows Advanced Threat Protection'
$Name = 'senseId'
try {
    Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop
    Remove-ItemProperty -Path $Path -Name $Name -Force -ErrorAction Stop
}
catch {
    Write-Warning "$_.Exception.Message" -WarningAction SilentlyContinue
}
