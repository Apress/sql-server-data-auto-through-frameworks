use [SSISConfig]
go

print 'Config.Applications table'
If Not Exists(Select [schemas].[name] + '.' + [tables].[name] As [Schema.Table]
              From [sys].[tables]
			  Join [sys].[schemas]
			    On [schemas].[schema_id] = [tables].[schema_id]
			  Where [schemas].[name] = N'config'
			    And [tables].[name] = N'Applications')
 begin
  print ' - Create config.Applications table'
  Create Table [config].[Applications]
   (
      ApplicationId int identity(1, 1)
	   Constraint PK_config_Applications Primary Key Clustered
    , ApplicationName nvarchar(255) Not NULL
	   Constraint UQ_config_Applications_ApplicationName
	    Unique
   )
  print ' - Config.Applications table created'
 end
Else
 begin
  print ' - Config.Applications table already exists.'
 end
print ''
go