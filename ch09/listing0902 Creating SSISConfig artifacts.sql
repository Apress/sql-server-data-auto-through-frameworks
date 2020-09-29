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

print 'Config.Applications table'
If Not Exists(Select [schemas].[name] + '.' + [tables].[name] 
As [Schema.Table]
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

print 'Config.Packages table'
If Not Exists(Select [schemas].[name] + '.' + [tables].[name]
As [Schema.Table]
              From [sys].[tables]
		  Join [sys].[schemas]
		    On [schemas].[schema_id] = [tables].[schema_id]
		  Where [schemas].[name] = N'config'
		    And [tables].[name] = N'Packages')
 begin
  print ' - Create config.Packages table'
  Create Table [config].[Packages]
   (
      PackageId int identity(1, 1)
	 Constraint PK_config_Packages Primary Key Clustered
    , PackageLocation nvarchar(255) Not NULL
    , PackageName nvarchar(255) Not NULL
    , Constraint UQ_config_Packages_PackageName
	 Unique(PackageLocation, PackageName)
   )
  print ' - Config.Packages table created'
 end
Else
 begin
  print ' - Config.Packages table already exists.'
 end
print ''
go

print 'Config.ApplicationPackages table'
If Not Exists(Select [schemas].[name] + '.' + [tables].[name]
As [Schema.Table]
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
go

Set NoCount ON

declare @PackageLocation nvarchar(255) = N'E:\Projects\TestSSISSolution\TestSSISProject\'
declare @PackageName nvarchar(255) = N'ReportAndSucceed.dtsx'

print @PackageLocation + @PackageName
declare @PackageId int = (Select [Packages].[PackageId]
                          From [config].[Packages]
			        Where [Packages].[PackageLocation] = @PackageLocation
				    And [Packages].[PackageName] = @PackageName)
If (@PackageId Is NULL)
 begin
  print ' - Adding ' + @PackageName + ' package to config.Packages table'

  declare @PkgTbl table(PackageId int)

  Insert Into [config].[Packages]
  (PackageLocation, PackageName)
  Output inserted.PackageId into @PkgTbl
  Values (@PackageLocation, @PackageName)

  Set @PackageId = (Select PackageId
                    From @PkgTbl)

  print ' - ' + @PackageName + ' package added to config.Packages table'
 end
Else
 begin
  print ' - ' + @PackageName + ' package already exists in the config.Packages table.'
 end

 Select @PackageId As PackageId
print ''

set @PackageName = N'ReportAndFail.dtsx'

print @PackageLocation + @PackageName
set @PackageId = (Select [Packages].[PackageId]
                  From [config].[Packages]
			Where [Packages].[PackageLocation] = @PackageLocation
			  And [Packages].[PackageName] = @PackageName)
If (@PackageId Is NULL)
 begin
  print ' - Adding ' + @PackageName + ' application to config.Packages table'

  Delete @PkgTbl

  Insert Into [config].[Packages]
  (PackageLocation, PackageName)
  Output inserted.PackageId into @PkgTbl
  Values (@PackageLocation, @PackageName)

  Set @PackageId = (Select PackageId
                    From @PkgTbl)

  print ' - ' + @PackageName + ' package added to config.Packages table'
 end
Else
 begin
  print ' - ' + @PackageName + ' package already exists in the config.Packages table.'
 end

 Select @PackageId As PackageId
print ''
go

Set NoCount ON

declare @ApplicationName nvarchar(255) = N'Framework Test'
declare @PackageLocation nvarchar(255) = N'E:\Projects\TestSSISSolution\TestSSISProject\'
declare @PackageName nvarchar(255) = N'ReportAndSucceed.dtsx'
declare @ExecutionOrder int = 10

print @ApplicationName + ' - ' + @PackageLocation + @PackageName

declare @ApplicationId int = (Select [Applications].[ApplicationId]
                              From [config].[Applications]
			            Where [Applications].[ApplicationName] = @ApplicationName)

declare @PackageId int = (Select [Packages].[PackageId]
                          From [config].[Packages]
			        Where [Packages].[PackageLocation] = @PackageLocation
				    And [Packages].[PackageName] = @PackageName)

declare @ApplicationPackageId int = (Select ApplicationPackageId
                                     From config.ApplicationPackages
						 Where ApplicationId = @ApplicationId
						   And PackageId = @PackageId
						   And ExecutionOrder = @ExecutionOrder)

If (@ApplicationPackageId Is NULL)
 begin
  print ' - Assigning ' + @PackageName + ' package to ' 
        + @ApplicationName + ' application' 
	  + ' in config.ApplicationPackages table'
	  + ' at ExecutionOrder ' + Convert(varchar(9), @ExecutionOrder)

  Insert Into [config].[ApplicationPackages]
  (ApplicationId
 , PackageId
 , ExecutionOrder)
  Values (@ApplicationId
        , @PackageId
	  , @ExecutionOrder)

  print ' - ' + @PackageName + ' package assigned to ' 
        + @ApplicationName + ' application' 
	  + ' in config.ApplicationPackages table'
	  + ' at ExecutionOrder ' + Convert(varchar(9), @ExecutionOrder)
 end
Else
 begin
print ' - ' + @PackageName + ' package already'
        + ' assigned to ' + @ApplicationName
	  + ' application in config.ApplicationPackages table'
	  + ' at ExecutionOrder ' + Convert(varchar(9), @ExecutionOrder)
	  + '.'
 end
print ''

set @PackageName = N'ReportAndFail.dtsx'
set @ExecutionOrder = 20

print @ApplicationName + ' - ' + @PackageLocation + @PackageName

set @ApplicationId = (Select [Applications].[ApplicationId]
                      From [config].[Applications]
			    Where [Applications].[ApplicationName] = @ApplicationName)

set @PackageId = (Select [Packages].[PackageId]
                  From [config].[Packages]
			Where [Packages].[PackageLocation] = @PackageLocation
			  And [Packages].[PackageName] = @PackageName)

set @ApplicationPackageId = (Select ApplicationPackageId
                             From config.ApplicationPackages
				     Where ApplicationId = @ApplicationId
				     	 And PackageId = @PackageId
					 And ExecutionOrder = @ExecutionOrder)

If (@ApplicationPackageId Is NULL)
 begin
  print ' - Assigning ' + @PackageName + ' package to ' 
        + @ApplicationName + ' application' 
	  + ' in config.ApplicationPackages table'
	  + ' at ExecutionOrder ' + Convert(varchar(9), @ExecutionOrder)

  Insert Into [config].[ApplicationPackages]
  (ApplicationId
 , PackageId
 , ExecutionOrder)
  Values (@ApplicationId
        , @PackageId
	  , @ExecutionOrder)

  print ' - ' + @PackageName + ' package assigned to ' 
        + @ApplicationName + ' application' 
	  + ' in config.ApplicationPackages table'
	  + ' at ExecutionOrder ' + Convert(varchar(9), @ExecutionOrder)
 end
Else
 begin
  print ' - ' + @PackageName + ' package already'
        + ' assigned to ' + @ApplicationName
	  + ' application in config.ApplicationPackages table'
	  + ' at ExecutionOrder ' + Convert(varchar(9), @ExecutionOrder)
	  + '.' 
 end
print ''
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

print 'Log.ApplicationInstance table'
If Not Exists(Select [schemas].[name] + '.' + [tables].[name] 
As [Schema.Table]
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

print 'Log.ApplicationPackageInstance table'
If Not Exists(Select [schemas].[name] + '.' + [tables].[name] 
As [Schema.Table]
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
