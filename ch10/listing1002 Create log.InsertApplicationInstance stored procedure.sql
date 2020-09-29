print 'log.InsertApplicationInstance stored procedure'
If Exists(Select s.[name] + '.' + p.[name]
          From [sys].[procedures] p
          Join [sys].[schemas] s
            On s.[schema_id] = p.[schema_id]
         Where s.[name] = N'log'
           And p.[name] = N'InsertApplicationInstance')
 begin
  print ' - Dropping log.InsertApplicationInstance stored procedure'
  Drop Procedure log.InsertApplicationInstance
  print ' - Log.InsertApplicationInstance stored procedure dropped'
 end

print ' - Creating log.InsertApplicationInstance stored procedure'
go

Create Procedure log.InsertApplicationInstance
   @ApplicationName nvarchar(255)
 , @ApplicationRunId nvarchar(55) = NULL
As

  declare @ApplicationId int = (Select ApplicationId
                                From config.Applications
                                Where ApplicationName = @ApplicationName)

  Insert Into [log].ApplicationInstance (ApplicationId, ApplicationRunId)
  Output inserted.ApplicationInstanceId
  Values (@ApplicationId, @ApplicationRunId)

go

print ' - Log.InsertApplicationInstance stored procedure created'
go
