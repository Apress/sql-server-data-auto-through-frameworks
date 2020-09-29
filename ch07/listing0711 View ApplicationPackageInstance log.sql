Select a.ApplicationName
     , p.PackageName
     , api.ApplicationPackageStartTime
     , ai.ApplicationStatus
     , api.ApplicationPackageStatus
     , api.ApplicationPackageStartTime
     , ap.FailApplicationOnPackageFailure
     , DateDiff(ms, api.ApplicationPackageStartTime,  api.ApplicationPackageEndTime) As ApplicationPackageRunMilliSeconds
     , ai.ApplicationStartTime
     , DateDiff(ms, ai.ApplicationStartTime, ai.ApplicationEndTime) As  ApplicationRunMilliSeconds
From [SSISConfig].[log].[ApplicationPackageInstance] api
Join [SSISConfig].[log].[ApplicationInstance] ai
  On ai.ApplicationInstanceId = api.ApplicationInstanceId
Join [SSISConfig].[config].[ApplicationPackages] ap
  On ap.ApplicationPackageId = api.ApplicationPackageId
Join [SSISConfig].[config].[Applications] a
  On a.ApplicationId = ap.ApplicationId
Join [SSISConfig].[config].[Packages] p
  On p.PackageId = ap.PackageId
Order By api.ApplicationPackageStartTime Desc
