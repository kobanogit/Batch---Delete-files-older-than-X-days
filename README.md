# Batch - Delete files older than X days
Windows Batch to delete files older than X days

In conjonction with SyncBackPro, wich can create zip archives of resource folders.

This batch permits to clean backup folders containing those zip archives, only conserving recent zip files from less than X days.


## How to :
```
API-delete-old-files.bat "folderName" 10
```
Will delete zip archives older than 10 days in folderName.

In SyncBackPro, export mode configuration, you can use "After Settings" to lauch this batch with "Run after profile" : `API-delete-old-files.bat "folderName" 10`
After zip archive creation, backup folder wil be cleaned with latest files

## Important Configuration :
All backup folders are in the same root folder. This root folder is actually defined :
- Selected Windows partition : D (line 10) 
-> change D to the letter of your drive

- Selected root folder : "D:/Backup & Maintenance/_BACKUP/"%folder% 
-> Change path to your root folder

`%folder%` represents the called backup folder containing zip archives.


## API-LAUNCHER.bat :
Used to check your configuration on a `test` folder.
You can use BulkFileChanger to change lastmodified date 
https://www.nirsoft.net/utils/bulk_file_changer.html

Actually calling :
```
API-delete-old-files.bat "test" 14
```


Improvements are welcome !

