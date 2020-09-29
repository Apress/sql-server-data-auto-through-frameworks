print 'SSISConfig database'
If Not Exists(Select [databases].[name]
              From [sys].[databases]
			  Where [databases].[name] = N'SSISConfig')
 begin
  print ' - Create SSISConfig database'
  Create Database SSISConfig
  print ' - SSISConfig database created'
 end
Else
 begin
  print ' - SSISConfig database already exists.'
 end
print ''
go
