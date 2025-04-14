
param (
    [int]$tempDiskLunNumber
)

Start-Sleep -Seconds 300

# Move DVD Drive letter from D: to Z:
# Define old and new DVD drive letters
$oldLetter = "D:"
$newLetter = "Z:"

# Get the volume object for the DVD drive
$dvdDrive = Get-WmiObject -Query "SELECT * FROM Win32_Volume WHERE DriveLetter = '$oldLetter' AND DriveType = 5"

# Change the drive letter
if ($dvdDrive) {
    $dvdDrive.DriveLetter = $newLetter
    $dvdDrive.Put() | Out-Null
    Write-Output "Drive letter changed from $oldLetter to $newLetter"
} else {
    Write-Output "DVD drive with letter $oldLetter not found."
}



# PowerShell script to initialize and mount the temporary disk
Get-Disk | Out-File -FilePath "C:\temp\diskinfo.txt" -Append
$disk = Get-Disk -Number $tempDiskLunNumber | Where-Object PartitionStyle -eq 'RAW'
if($disk) {
    Initialize-Disk -Number $disk.Number -PartitionStyle MBR -PassThru | New-Partition DriveLetter D -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Temp"
}