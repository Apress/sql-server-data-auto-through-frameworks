print 'Log.ApplicationInstance.ApplicationRunId column'
If Not Exists(Select s.[name] 
             + '.' + t.[name] 
             + '.' + c.[name]
              From [sys].[schemas] s
              Join [sys].[tables] t 
                On t.[schema_id] = s.[schema_id]
              Join [sys].[columns] c 
                On c.[object_id] = t.[object_id]
              Where s.[name] = N'log'
                And t.[name] = N'ApplicationInstance'
                And c.[name] = N'ApplicationRunId')
  begin
   print ' - Adding log.ApplicationInstance.ApplicationRunId column'
   Alter Table log.ApplicationInstance
    Add ApplicationRunId nvarchar(55) NULL
   print ' - Log.ApplicationInstance.ApplicationRunId column added'
  end 
Else 
  begin
   print ' - Log.ApplicationInstance.ApplicationRunId column already exists.'
  end 
