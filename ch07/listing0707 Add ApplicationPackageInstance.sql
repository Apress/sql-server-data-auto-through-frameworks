declare @ApplicationPackageId int = (
  Select ap.ApplicationPackageId
  From config.ApplicationPackages ap
  Join config.Applications a
    On a.ApplicationId = ap.ApplicationId
  Join config.Packages p
    On p.PackageId = ap.PackageId
  Where ApplicationName = @ApplicationName
    And p.PackageLocation + p.PackageName = @PackagePath
)

Insert Into [log].ApplicationPackageInstance 
(ApplicationInstanceId, ApplicationPackageId)
Output inserted.ApplicationPackageInstanceId
Values (@ApplicationInstanceId, @ApplicationPackageId)
