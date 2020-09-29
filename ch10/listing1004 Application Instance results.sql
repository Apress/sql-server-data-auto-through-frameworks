Select a.ApplicationName
     , ai.ApplicationStartTime
     , ai.ApplicationStatus
From log.ApplicationInstance ai
Join config.Applications a
  On a.ApplicationId = ai.ApplicationId
Order By ApplicationInstanceId DESC
