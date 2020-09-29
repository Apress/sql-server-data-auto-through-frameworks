Select a.ApplicationName
     , p.PackageLocation + p.PackageName As PackagePath
     , ap.ExecutionOrder
     , ap.FailApplicationOnPackageFailure
From [config].[ApplicationPackages] ap
Join [config].[Applications] a
  On a.ApplicationId = ap.ApplicationId
Join [config].Packages p
  On p.PackageId = ap.PackageId
Where a.ApplicationName = @ApplicationName
  And ap.ApplicationPackageEnabled = 1
Order By ap.ExecutionOrder
