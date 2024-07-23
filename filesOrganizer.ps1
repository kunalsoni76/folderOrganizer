# Assuming $folderPath is defined earlier in the script

# Create folders for different file types if they don't exist
$folders = @("Images", "Documents", "Music", "Videos", "Others")
foreach ($folder in $folders) {
    $tempFolderPath = Join-Path $folderPath $folder
    if (-not (Test-Path $tempFolderPath)) {
        New-Item -Path $tempFolderPath -ItemType Directory
    }
}

# Get all files in the folder, excluding directories
$files = Get-ChildItem $folderPath -File

# Define extensions for each type of file
$imageExtensions = @(".jpg", ".jpeg", ".png", ".gif")
$documentExtensions = @(".doc", ".docx", ".pdf", ".txt")
$musicExtensions = @(".mp3", ".wav")
$videoExtensions = @(".mp4", ".avi", ".mov")

# Move files to respective folders based on their extension
foreach ($file in $files) {
    $extension = $file.Extension
    $destinationFolder = ""

    if ($imageExtensions -contains $extension) {
        $destinationFolder = "Images"
    } elseif ($documentExtensions -contains $extension) {
        $destinationFolder = "Documents"
    } elseif ($musicExtensions -contains $extension) {
        $destinationFolder = "Music"
    } elseif ($videoExtensions -contains $extension) {
        $destinationFolder = "Videos"
    } else {
        $destinationFolder = "Others"
    }

    $destinationPath = Join-Path $folderPath $destinationFolder
    Move-Item -Path $file.FullName -Destination $destinationPath
}
