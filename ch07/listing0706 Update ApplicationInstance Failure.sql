Update [log].ApplicationInstance
Set ApplicationEndTime = sysdatetimeoffset()
   , ApplicationStatus = 'Failed'
Where ApplicationInstanceId = @ApplicationInstanceId
