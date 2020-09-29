Update [log].ApplicationPackageInstance
Set ApplicationPackageEndTime = sysdatetimeoffset()
   , ApplicationPackageStatus = 'Succeeded'
Where ApplicationPackageInstanceId = @ApplicationPackageInstanceId
