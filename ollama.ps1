#!/usr/bin/env pwsh

# port to listen to
$port = 3007
$uri = "http://localhost:$port"

# start docker desktop if not already running
$null = docker ps 2>&1
$dockerRunning = $?

if (!$dockerRunning)
{
    $dockerPath = "C:\Program Files\Docker\Docker\Docker Desktop.exe"

    Write-Output "Starting docker desktop at path $dockerPath..."
    Start-Process $dockerPath

    if (!$?)
    {
        Write-Error "Error starting docker desktop, is it installed?"
        return
    }

    while ($true)
    {
        Start-Sleep -Seconds 5

        $null = docker ps 2>&1

        $dockerRunning = $?

        if ($dockerRunning)
        {
            break
        }

        Write-Output "..."
    }

    Write-Output "Docker desktop was successfully started!"
}

# run the service
Push-Location $PSScriptRoot
try
{
    docker-compose up -d
    try
    {
        Start-Sleep -Seconds 5

        Write-Output "Running on $uri"

        Start-Process $uri

        [console]::TreatControlCAsInput = $true
        Write-Output "Hit Control-C to exit"
        while ($true)
        {
            if ([console]::KeyAvailable)
            {
                $key = [system.console]::readkey($true)
                if (($key.modifiers -band [consolemodifiers]"control") -and (($key.key -eq "C") -or ($key.key -eq "D")))
                {
                    break
                }
            }
        }

        Write-Output "Shutting it down..."
    }
    finally
    {
        docker-compose down
    }
}
finally
{
    Pop-Location

    Write-Output "Docker-Desktop was left running, remember to close it if you want to."

    [console]::TreatControlCAsInput = $false
}