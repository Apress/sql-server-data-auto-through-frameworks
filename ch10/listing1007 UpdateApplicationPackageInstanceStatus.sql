print 'log.UpdateApplicationPackageInstanceStatus stored procedure'
If Exists(Select s.[name] + '.' + p.[name]
          From [sys].[procedures] p
          Join [sys].[schemas] s
            On s.[schema_id] = p.[schema_id]
          Where s.[name] = N'log'
            And p.[name] = N'UpdateApplicationPackageInstanceStatus')
 begin
  print ' - Dropping log.UpdateApplicationPackageInstanceStatus stored procedure'
  Drop Procedure log.UpdateApplicationPackageInstanceStatus
  print ' - Log.UpdateApplicationPackageInstanceStatus stored procedure dropped'
 end

print ' - Creating log.UpdateApplicationPackageInstanceStatus stored procedure'
go

Create Procedure log.UpdateApplicationPackageInstanceStatus
   @ApplicationPackageInstanceId int
 , @ApplicationPackageStatus nvarchar(55) = 'Succeeded'
As

  Update [log].ApplicationPackageInstance
  Set ApplicationPackageEndTime = sysdatetimeoffset()
    , ApplicationPackageStatus = @ApplicationPackageStatus
  Where ApplicationPackageInstanceId = @ApplicationPackageInstanceId

go

print ' - Log.UpdateApplicationPackageInstanceStatus stored procedure created'
go 
