use [SSISConfig]
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