Select p.PackageLocation + p.PackageName As PackagePath
From [config].[Packages] p

Update [config].[Packages]
Set PackageLocation  = N'\\stframeworks.file.core.windows.net\fs-ssis\'
Where PackageLocation  = N'E:\Projects\TestSSISSolution\TestSSISProject\'

Select p.PackageLocation + p.PackageName As PackagePath
From [config].[Packages] p
