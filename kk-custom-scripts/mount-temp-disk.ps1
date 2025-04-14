
param (
    [int]$tempDiskLunNumber
)

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
$disk = Get-Disk -Number $tempDiskLunNumber | Where-Object PartitionStyle -eq 'RAW'
if($disk) {
    Initialize-Disk -Number $disk.Number -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "TempDisk"
}