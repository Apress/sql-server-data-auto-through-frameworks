Use [SSISConfig]
go

print 'Log schema'
If Not Exists(Select [schemas].[name]
              From [sys].[schemas]
			  Where [schemas].[name] = N'log')
 begin
  print ' - Create log schema'
  declare @sql nvarchar(100) = N'Create Schema log'
  exec(@sql)
  print ' - Log schema created'
 end
Else
 begin
  print ' - Log schema already exists.'
 end
print ''
go
