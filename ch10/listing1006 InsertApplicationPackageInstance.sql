print 'log.InsertApplicationPackageInstance stored procedure'
If Exists(Select s.[name] + '.' + p.[name]
          From [sys].[procedures] p
          Join [sys].[schemas] s
            On s.[schema_id] = p.[schema_id]
          Where s.[name] = N'log'
            And p.[name] = N'InsertApplicationPackageInstance')
 begin
  print ' - Dropping log.InsertApplicationPackageInstance stored procedure'
  Drop Procedure log.InsertApplicationPackageInstance
  print ' - Log.InsertApplicationPackageInstance stored procedure dropped'
 end

print ' - Creating log.InsertApplicationPackageInstance stored procedure'
go

Create Procedure log.InsertApplicationPackageInstance
   @ApplicationInstanceId int
 , @ApplicationPackageId int
 , @ApplicationPackageRunId nvarchar(55) = NULL
As

  Insert Into [log].ApplicationPackageInstance 
  ( ApplicationInstanceId
  , ApplicationPackageId
  , ApplicationPackageRunId)
  Output inserted.ApplicationPackageInstanceId
  Values 
  ( @ApplicationInstanceId
  , @ApplicationPackageId
  , @ApplicationPackageRunId)

go

print ' - Log.InsertApplicationPackageInstance stored procedure created'
go
