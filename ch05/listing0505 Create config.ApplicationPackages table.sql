use [SSISConfig]
go

print 'Config.ApplicationPackages table'
If Not Exists(Select [schemas].[name] + '.' + [tables].[name] As [Schema.Table]
              From [sys].[tables]
			  Join [sys].[schemas]
			    On [schemas].[schema_id] = [tables].[schema_id]
			  Where [schemas].[name] = N'config'
			    And [tables].[name] = N'ApplicationPackages')
 begin
  print ' - Create config.ApplicationPackages table'
  Create Table [config].[ApplicationPackages]
   (
      ApplicationPackageId int identity(1, 1)
	   Constraint PK_config_ApplicationPackages Primary Key Clustered
	, ApplicationId int Not NULL
	   Constraint FK_config_ApplicationPackages_config_Applications
	    Foreign Key References [config].[Applications](ApplicationId)
    , PackageId int Not NULL
	   Constraint FK_config_ApplicationPackages_config_Packages
	    Foreign Key References [config].[Packages](PackageId)
	, ExecutionOrder int Not NULL
	   Constraint DF_config_ApplicationPackages_ExecutionOrder
		Default(10)
	, ApplicationPackageEnabled bit Not NULL
	   Constraint DF_config_ApplicationPackages_ApplicationPackageEnabled
		Default(1)
	, FailApplicationOnPackageFailure bit Not NULL
       Constraint DF_config_ApplicationPackages_FailApplicationOnPackageFailure
	    Default(1)
	, Constraint UQ_config_ApplicationPackages_ApplicationId_PackageId_ExecutionOrder
	    Unique(ApplicationId, PackageId, ExecutionOrder)
   )
  print ' - Config.ApplicationPackages table created'
 end
Else
 begin
  print ' - Config.ApplicationPackages table already exists.'
 end
print ''
go