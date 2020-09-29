Update [log].ApplicationPackageInstance
Set ApplicationPackageEndTime = sysdatetimeoffset()
   , ApplicationPackageStatus = 'Failed'
Where ApplicationPackageInstanceId = @ApplicationPackageInstanceId
