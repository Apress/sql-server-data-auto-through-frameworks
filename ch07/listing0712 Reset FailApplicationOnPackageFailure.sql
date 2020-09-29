Select p.PackageName
     , ap.FailApplicationOnPackageFailure
From [SSISConfig].[config].[ApplicationPackages] ap
Join [SSISConfig].[config].[Packages] p
  On p.PackageId = ap.PackageId
Where p.PackageName = N'ReportAndFail.dtsx'

Update ap
Set ap.FailApplicationOnPackageFailure = 0
From [SSISConfig].[config].[ApplicationPackages] ap
Join [SSISConfig].[config].[Packages] p
  On p.PackageId = ap.PackageId
Where p.PackageName = N'ReportAndFail.dtsx'

Select p.PackageName
     , ap.FailApplicationOnPackageFailure
From [SSISConfig].[config].[ApplicationPackages] ap
Join [SSISConfig].[config].[Packages] p
  On p.PackageId = ap.PackageId
Where p.PackageName = N'ReportAndFail.dtsx'
