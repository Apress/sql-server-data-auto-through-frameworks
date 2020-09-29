Select a.ApplicationName
     , p.PackageLocation + p.PackageName As PackagePath
     , ap.ExecutionOrder
     , ap.FailApplicationOnPackageFailure
     , ap.ApplicationPackageId
From [config].[ApplicationPackages] ap
Join [config].[Applications] a
  On a.ApplicationId = ap.ApplicationId
Join [config].Packages p
  On p.PackageId = ap.PackageId
Where a.ApplicationName = N'Framework Test'
  And ap.ApplicationPackageEnabled = 1
Order By ap.ExecutionOrder
