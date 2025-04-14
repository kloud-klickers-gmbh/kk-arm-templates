

# PowerShell script to initialize and mount the temporary disk
$disk = Get-Disk | Where-Object PartitionStyle -eq 'RAW'
Initialize-Disk -Number $disk.Number -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "TempDisk"