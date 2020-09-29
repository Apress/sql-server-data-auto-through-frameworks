print 'Log.ApplicationPackageInstance.ApplicationPackageRunId column'
If Not Exists(Select s.[name] 
             + '.' + t.[name] 
             + '.' + c.[name]
              From [sys].[schemas] s
              Join [sys].[tables] t 
                On t.[schema_id] = s.[schema_id]
              Join [sys].[columns] c 
                On c.[object_id] = t.[object_id]
              Where s.[name] = N'log'
                And t.[name] = N'ApplicationPackageInstance'
                And c.[name] = N'ApplicationPackageRunId')
  begin
   print ' - Adding log.ApplicationPackageInstance.ApplicationPackageRunId  column'
   Alter Table log.ApplicationPackageInstance
    Add ApplicationPackageRunId nvarchar(55) NULL
   print ' - Log.ApplicationPackageInstance.ApplicationPackageRunId column  added'
  end 
Else 
  begin
   print ' - Log.ApplicationPackageInstance.ApplicationPackageRunId column  already exists.'
  end
