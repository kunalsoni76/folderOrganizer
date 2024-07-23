# This script uses powershell to identify type of files in a folder and move them to respective folders.

# Get the path of the folder to organize
$folderPath = Read-Host "Enter the path of the folder to organize"

# Create lists of extensions for different file types
$imageExtensions = @(".jpg", ".png", ".gif")
$documentExtensions = @(".docx", ".pdf", ".txt")
$musicExtensions = @(".mp3", ".wav", ".flac")
$videoExtensions = @(".mp4", ".avi", ".mkv")

# Check if the folder exists
if (-not (Test-Path $folderPath)) {
    Write-Host "Folder does not exist"
    exit
}

# Create folders for different file types

$folders = @("Images", "Documents", "Music", "Videos", "Others")

foreach ($folder in $folders) {
    $folderPath = Join-Path $folderPath $folder
    if (-not (Test-Path $folderPath)) {
        New-Item -Path $folderPath -ItemType Directory
    }
}

# Get all files in the folder
$files = Get-ChildItem $folderPath

# Move files to respective folders
foreach ($file in $files) {
    $extension = $file.Extension
    switch ($extension) {
       {$extension -in $imageExtensions} {
            Move-Item -Path $file.FullName -Destination (Join-Path $folderPath "Images")
        }
        {$extension -in $documentExtensions} {
            Move-Item -Path $file.FullName -Destination (Join-Path $folderPath "Documents")
        }
        {$extension -in $musicExtensions} {
            Move-Item -Path $file.FullName -Destination (Join-Path $folderPath "Music")
        }
        {$extension -in $videoExtensions} {
            Move-Item -Path $file.FullName -Destination (Join-Path $folderPath "Videos")
        }
        default {
            Move-Item -Path $file.FullName -Destination (Join-Path $folderPath "Others")
        }
    }
}