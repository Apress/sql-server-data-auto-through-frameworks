print 'log.UpdateApplicationInstanceStatus stored procedure'
If Exists(Select s.[name] + '.' + p.[name]
          From [sys].[procedures] p
          Join [sys].[schemas] s
            On s.[schema_id] = p.[schema_id]
          Where s.[name] = N'log'
            And p.[name] = N'UpdateApplicationInstanceStatus')
 begin
  print ' - Dropping log.UpdateApplicationInstanceStatus stored procedure'
  Drop Procedure log.UpdateApplicationInstanceStatus
  print ' - Log.UpdateApplicationInstanceStatus stored procedure dropped'
 end

print ' - Creating log.UpdateApplicationInstanceStatus stored procedure'
go

Create Procedure log.UpdateApplicationInstanceStatus
   @ApplicationInstanceId int
 , @ApplicationStatus nvarchar(55) = 'Succeeded'
As

  Update [log].ApplicationInstance
  Set ApplicationEndTime = sysdatetimeoffset()
    , ApplicationStatus = @ApplicationStatus
  Where ApplicationInstanceId = @ApplicationInstanceId

go

print ' - Log.UpdateApplicationInstanceStatus stored procedure created'
go 
