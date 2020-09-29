use [SSISConfig]
go

print 'Config schema'
If Not Exists(Select [schemas].[name]
              From [sys].[schemas]
			  Where [schemas].[name] = N'config')
 begin
  print ' - Create config schema'
  declare @sql nvarchar(100) = N'Create Schema config'
  exec(@sql)
  print ' - Config schema created'
 end
Else
 begin
  print ' - Config schema already exists.'
 end
print ''
go