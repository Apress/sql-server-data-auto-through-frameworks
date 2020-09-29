use [SSISConfig]
go

print 'Config.Packages table'
If Not Exists(Select [schemas].[name] + '.' + [tables].[name] As [Schema.Table]
              From [sys].[tables]
			  Join [sys].[schemas]
			    On [schemas].[schema_id] = [tables].[schema_id]
			  Where [schemas].[name] = N'config'
			    And [tables].[name] = N'Packages')
 begin
  print ' - Create config.Packages table'
  Create Table [config].[Packages]
   (
      PackageId int identity(1, 1)
	   Constraint PK_config_Packages Primary Key Clustered
	, PackageLocation nvarchar(255) Not NULL
    , PackageName nvarchar(255) Not NULL
	, Constraint UQ_config_Packages_PackageName
	    Unique(PackageLocation, PackageName)
   )
  print ' - Config.Packages table created'
 end
Else
 begin
  print ' - Config.Packages table already exists.'
 end
print ''
go