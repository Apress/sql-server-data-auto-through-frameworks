use [SSISConfig]
go

print 'Log.ApplicationInstance table'
If Not Exists(Select [schemas].[name] + '.' + [tables].[name] As [Schema.Table]
              From [sys].[tables]
			  Join [sys].[schemas]
			    On [schemas].[schema_id] = [tables].[schema_id]
			  Where [schemas].[name] = N'log'
			    And [tables].[name] = N'ApplicationInstance')
 begin
  print ' - Create log.ApplicationInstance table'
  Create Table [log].[ApplicationInstance]
   (
      ApplicationInstanceId int identity(1, 1)
	   Constraint PK_log_ApplicationInstance Primary Key Clustered
    , ApplicationId int Not NULL
	   Constraint FK_log_ApplicationInstance_config_Applications
	    Foreign Key References [config].[Applications](ApplicationId)
	, ApplicationStartTime datetimeoffset(7) Not NULL
	   Constraint DF_log_ApplicationInstance_ApplicationStartTime
		Default(sysdatetimeoffset())
	, ApplicationEndTime datetimeoffset(7) NULL
	, ApplicationStatus nvarchar(25) Not NULL
       Constraint DF_log_ApplicationInstance_ApplicationStatus
	    Default(N'Running')
   )
  print ' - Log.ApplicationInstance table created'
 end
Else
 begin
  print ' - Log.ApplicationInstance table already exists.'
 end
print ''
go