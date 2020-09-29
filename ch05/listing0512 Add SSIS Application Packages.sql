use [SSISConfig]
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