<<<<<<< HEAD
﻿$srcPath = "F:\FarmingSimulator2019\mods-dev\FS19_VehicleSort"
$dstPath = "F:\FarmingSimulator2019\mods-dev\FS19_VehicleSort"
$dstFilename = "FS19_VehicleSort.zip"
=======
﻿$srcPath = "F:\FarmingSimulator2019\mods-dev\FS19_VehicleExplorer"
$dstPath = "F:\FarmingSimulator2019\mods-dev\FS19_VehicleExplorer"
$dstFilename = "FS19_VehicleExplorer.zip"
>>>>>>> dev
$tmpPath = Join-Path $env:TMP "TmpZip"

$ignorelist = get-content (Join-Path $srcPath ".gitignore")
$ignorelist += "/New-ModZip.ps1"


[array]$allFiles = Get-ChildItem -Path $srcPath -Exclude {.gitignore} -Recurse -Attributes !Directory
[array]$allFolders = Get-ChildItem -Path $srcPath -Exclude {.gitignore} -Recurse -Attributes Directory


foreach($f in $allFolders)
{
    New-Item -ItemType Directory -Path $f.FullName.ToString().Replace($srcPath, $tmpPath)
}


foreach($f in $allFiles)
{   
    if( -not $ignorelist.contains($f.FullName.ToString().Replace("$srcPath", "").Replace("\","/")) )
    {
        #$F.FullName
        #$F.FullName.ToString().Replace($srcPath, $tmpPath)
        Copy-Item $f.FullName -Destination $f.FullName.ToString().Replace($srcPath, $tmpPath) -Force
    }
}

Compress-Archive -Path (Join-Path $tmpPath "\*") -DestinationPath (Join-Path $dstPath $dstFilename)

Remove-Item -Path $tmpPath -Recurse -Force