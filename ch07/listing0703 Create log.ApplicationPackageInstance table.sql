use [SSISConfig]
go

print 'Log.ApplicationPackageInstance table'
If Not Exists(Select [schemas].[name] + '.' + [tables].[name] As [Schema.Table]
              From [sys].[tables]
			  Join [sys].[schemas]
			    On [schemas].[schema_id] = [tables].[schema_id]
			  Where [schemas].[name] = N'log'
			    And [tables].[name] = N'ApplicationPackageInstance')
 begin
  print ' - Create log.ApplicationPackageInstance table'
  Create Table [log].[ApplicationPackageInstance]
   (
      ApplicationPackageInstanceId int identity(1, 1)
	   Constraint PK_log_ApplicationPackageInstance Primary Key Clustered
	, ApplicationInstanceId int Not NULL
	   Constraint FK_log_ApplicationPackageInstance_log_ApplicationInstance
	    Foreign Key References [log].[ApplicationInstance](ApplicationInstanceId)
    , ApplicationPackageId int Not NULL
	   Constraint FK_log_ApplicationPackageInstance_config_ApplicationPackages
	    Foreign Key References [config].[ApplicationPackages](ApplicationPackageId)
	, ApplicationPackageStartTime datetimeoffset(7) Not NULL
	   Constraint DF_log_ApplicationPackageInstance_ApplicationPackageStartTime
		Default(sysdatetimeoffset())
	, ApplicationPackageEndTime datetimeoffset(7) NULL
	, ApplicationPackageStatus nvarchar(25) Not NULL
       Constraint DF_log_ApplicationPackageInstance_ApplicationPackageStatus
	    Default(N'Running')
   )
  print ' - Log.ApplicationPackageInstance table created'
 end
Else
 begin
  print ' - Log.ApplicationPackageInstance table already exists.'
 end
print ''
go