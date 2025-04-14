# Move DVD Drive letter from D: to Z:
# Define old and new DVD drive letters
$oldLetter = "D:"
$newLetter = "Z:"

# Get the volume object for the DVD drive
$dvdDrive = Get-WmiObject -Query "SELECT * FROM Win32_Volume WHERE DriveLetter = '$oldLetter' AND DriveType = 5"
$dvdDrive | Out-File -FilePath "C:\temp\mount-temp-disk.log" -Append

# Change the drive letter
if ($dvdDrive) {
    $dvdDrive.DriveLetter = $newLetter
    $dvdDrive.Put() | Out-Null
    Write-Output "Drive letter changed from $oldLetter to $newLetter" | Out-File -FilePath "C:\temp\mount-temp-disk.log" -Append
} else {
    Write-Output "DVD drive with letter $oldLetter not found." | Out-File -FilePath "C:\temp\mount-temp-disk.log" -Append
}



# PowerShell script to initialize and mount the temporary disk
Get-Disk | Out-File -FilePath "C:\temp\mount-temp-disk.log" -Append
$disk = Get-Disk -FriendlyName "Microsoft NVMe Direct Disk v2" | Where-Object PartitionStyle -eq 'RAW'
$disk | Out-File -FilePath "C:\temp\mount-temp-disk.log" -Append

if($disk) {
    Initialize-Disk -Number $disk.Number -PartitionStyle MBR -PassThru | New-Partition DriveLetter D -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Temp"| Out-File -FilePath "C:\temp\mount-temp-disk.log" -Append
}