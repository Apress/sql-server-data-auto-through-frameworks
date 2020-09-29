Select a.ApplicationName
     , ai.ApplicationStartTime
     , DateDiff(ms, ai.ApplicationStartTime, ai.ApplicationEndTime) As ApplicationRunMilliSeconds
     , ai.ApplicationStatus
From [SSISConfig].[log].[ApplicationInstance] ai
Join [SSISConfig].[config].[Applications] a
  On a.ApplicationId = ai.ApplicationId
Order By ai.ApplicationStartTime Desc
