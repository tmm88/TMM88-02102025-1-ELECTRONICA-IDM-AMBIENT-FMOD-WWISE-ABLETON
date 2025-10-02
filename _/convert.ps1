Get-ChildItem -Recurse -Include *.wav -ErrorAction SilentlyContinue | ForEach-Object {
    try {
        $inputFile = $_.FullName
        $outputFile = [System.IO.Path]::ChangeExtension($_.FullName, ".ogg")
        ffmpeg -i "$inputFile" -c:a libopus "$outputFile" -y -loglevel error
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Successfully converted: $inputFile to $outputFile"
        } else {
            Write-Host "Error converting: $inputFile" -ForegroundColor Red
        }
    } catch {
        Write-Host "Error processing $inputFile : $_" -ForegroundColor Red
    }
}