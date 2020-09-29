use [SSISConfig]
go

Set NoCount ON

declare @ApplicationName nvarchar(255) = N'Framework Test'

print @ApplicationName
declare @ApplicationId int = (Select [Applications].[ApplicationId]
                              From [config].[Applications]
			                  Where [Applications].[ApplicationName] = @ApplicationName)
If (@ApplicationId Is NULL)
 begin
  print ' - Adding ' + @ApplicationName + ' application to config.Applications table'

  declare @AppTbl table(ApplicationId int)

  Insert Into [config].[Applications]
  (ApplicationName)
  Output inserted.ApplicationId into @AppTbl
  Values (@ApplicationName)

  Set @ApplicationId = (Select ApplicationId
                        From @AppTbl)

  print ' - ' + @ApplicationName + ' application added to config.Applications table'
 end
Else
 begin
  print ' - ' + @ApplicationName + ' application already exists in the config.Applications table.'
 end

 Select @ApplicationId As ApplicationId
print ''