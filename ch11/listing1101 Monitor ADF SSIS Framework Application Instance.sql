Select top 1
   a.ApplicationName
 , ai.ApplicationInstanceId
 , ai.ApplicationStatus
From log.ApplicationInstance ai
Join config.Applications a 
  On a.ApplicationId = ai.ApplicationId
Order By ApplicationInstanceId Desc

declare @ApplicationInstanceId int = (Select top 1 ApplicationInstanceId
                                      From log.ApplicationInstance
                                      Order By ApplicationInstanceId DESC)

Select p.PackageName
  , ai.ApplicationInstanceId
  , api.ApplicationPackageInstanceId
  , api.ApplicationPackageStatus
  , ap.FailApplicationOnPackageFailure
From log.ApplicationPackageInstance api
Join log.ApplicationInstance ai 
  On ai.ApplicationInstanceId = api.ApplicationInstanceId
Join config.ApplicationPackages ap
  On ap.ApplicationPackageId = api.ApplicationPackageId
Join config.Packages p 
  On p.PackageId = ap.PackageId
Where ai.ApplicationInstanceId = @ApplicationInstanceId
Order By ApplicationPackageInstanceId
