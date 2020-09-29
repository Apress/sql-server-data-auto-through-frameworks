Update [log].ApplicationInstance
Set ApplicationEndTime = sysdatetimeoffset()
   , ApplicationStatus = 'Succeeded'
Where ApplicationInstanceId = @ApplicationInstanceId
