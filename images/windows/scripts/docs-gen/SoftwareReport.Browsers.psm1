$browsers = @{
    chrome = @{
        Name="Google Chrome";
        File="chrome.exe"
    };
    edge = @{
        Name="Microsoft Edge";
        File="msedge.exe"
    };
    firefox = @{
        Name="Mozilla Firefox";
        File="firefox.exe"
    }
}

$webDrivers = @{
    chrome = @{
        Name="Chrome Driver";
        Path="C:\SeleniumWebDrivers\ChromeDriver"
    };
    edge = @{
        Name="Microsoft Edge Driver";
        Path="C:\SeleniumWebDrivers\EdgeDriver"
    };
    firefox = @{
        Name="Gecko Driver";
        Path="C:\SeleniumWebDrivers\GeckoDriver"
    };
    iexplorer = @{
        Name="IE Driver";
        Path="C:\SeleniumWebDrivers\IEDriver"
    }
}

function Build-BrowserSection {
    $nodes = @(
        $(Get-BrowserVersion -Browser "chrome"),
        $(Get-SeleniumWebDriverVersion -Driver "chrome"),
        $(Get-BrowserVersion -Browser "edge"),
        $(Get-SeleniumWebDriverVersion -Driver "edge"),
        $(Get-BrowserVersion -Browser "firefox"),
        $(Get-SeleniumWebDriverVersion -Driver "firefox"),
        $(Get-SeleniumWebDriverVersion -Driver "iexplorer"),
        $(Get-SeleniumVersion)
    )
    # Filter out null values for disabled/missing browsers and drivers
    return $nodes | Where-Object { $null -ne $_ }
}

function Get-BrowserVersion {
    param(
        [string] $Browser
    )
    $browserName = $browsers.$Browser.Name
    $browserFile = $browsers.$Browser.File
    $registryKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$browserFile"

    # Skip if browser is not installed (e.g., Firefox may be disabled)
    if (-not (Test-Path $registryKey)) {
        Write-Host "Browser $browserName not found in registry, skipping..."
        return $null
    }

    $browserVersion = (Get-Item (Get-ItemProperty $registryKey)."(Default)").VersionInfo.FileVersion
    return [ToolVersionNode]::new($browserName, $browserVersion)
}

function Get-SeleniumWebDriverVersion {
    param(
        [string] $Driver
    )
    $driverName = $webDrivers.$Driver.Name
    $driverPath = $webDrivers.$Driver.Path
    $versionFileName = "versioninfo.txt";

    # Skip if WebDriver is not installed (e.g., GeckoDriver for Firefox)
    if (-not (Test-Path $driverPath)) {
        Write-Host "WebDriver $driverName not found at $driverPath, skipping..."
        return $null
    }

    $versionFilePath = "$driverPath\$versionFileName"
    if (-not (Test-Path $versionFilePath)) {
        Write-Host "Version file for $driverName not found, skipping..."
        return $null
    }

    $webDriverVersion = Get-Content -Path $versionFilePath
    return [ToolVersionNode]::new($driverName, $webDriverVersion)
}

function Get-SeleniumVersion {
    $seleniumBinaryName = "selenium-server"
    $fullSeleniumVersion = (Get-ChildItem "C:\selenium\${seleniumBinaryName}-*").Name -replace "${seleniumBinaryName}-"
    return [ToolVersionNode]::new("Selenium server", $fullSeleniumVersion)
}

function Build-BrowserWebdriversEnvironmentTable {
    return @(
        @{
            "Name" = "CHROMEWEBDRIVER"
            "Value" = $env:CHROMEWEBDRIVER
        },
        @{
            "Name" = "EDGEWEBDRIVER"
            "Value" = $env:EDGEWEBDRIVER
        },
        @{
            "Name" = "GECKOWEBDRIVER"
            "Value" = $env:GECKOWEBDRIVER
        },
        @{
            "Name" = "SELENIUM_JAR_PATH"
            "Value" = $env:SELENIUM_JAR_PATH
        }
    ) | ForEach-Object {
        [PSCustomObject] @{
            "Name" = $_.Name
            "Value" = $_.Value
        }
    }
}
