-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[AccountType]

CREATE TABLE [dbo].[AccountType]
(
 [id]   int IDENTITY (1, 1) NOT NULL ,
 [type] nvarchar(25) NOT NULL ,


 CONSTRAINT [PKC_AccountType_id] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Account]

CREATE TABLE [dbo].[Account]
(
 [id]              int IDENTITY (1, 1) NOT NULL ,
 [username]        nvarchar(25) NOT NULL ,
 [password]        nvarchar(255) NOT NULL ,
 [createdAt]       datetime NOT NULL ,
 [updatedAt]       datetime NOT NULL ,
 [lastlogin]       datetime NOT NULL ,
 [isVerified]      bit NOT NULL ,
 [accountTypeId]   int NOT NULL ,
 [isActive]        bit NOT NULL ,
 [profilePhotoUrl] nvarchar(max) NULL ,


 CONSTRAINT [PKC_Account] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_AccountType_id__Account_id] FOREIGN KEY ([accountTypeId])  REFERENCES [dbo].[AccountType]([id]),
 CONSTRAINT [UK_Account_username] UNIQUE ([username])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Account_accountTypeId] ON [dbo].[Account] 
 (
  [accountTypeId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Email]

CREATE TABLE [dbo].[Email]
(
 [id]        int IDENTITY (1, 1) NOT NULL ,
 [email]     nvarchar(255) NOT NULL ,
 [type]      nvarchar(25) NULL ,
 [accountId] int NOT NULL ,


 CONSTRAINT [PKC_Email] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__Email_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id]),
 CONSTRAINT [UK_Email_email] UNIQUE ([email])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Email_accountId] ON [dbo].[Email] 
 (
  [accountId] ASC
 )

GO




-- *************** I coded this: Microsoft SQL Server ***************
-- ******************************************************************

-- ************************************** [dbo].[AccountVerification]

CREATE TABLE [dbo].[AccountVerification]
(
    [id]            int IDENTITY (1, 1) NOT NULL,
    [accountId]     int NOT NULL,
    [accessToken]   NVARCHAR(255) NOT NULL,
    [exp]           NVARCHAR(16)

    CONSTRAINT [PKC_AccountVerification_id] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [UK_AccountVerification_accountId] UNIQUE ([accountId])
);
GO







-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[PhoneNumber]

CREATE TABLE [dbo].[PhoneNumber]
(
 [id]          int IDENTITY (1, 1) NOT NULL ,
 [phoneNumber] nvarchar(255) NOT NULL ,
 [type]        nvarchar(25) NULL ,
 [accountId]   int NOT NULL ,


 CONSTRAINT [PKC_PhoneNumber] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__PhoneNumber_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_PhoneNumber_accountId] ON [dbo].[PhoneNumber] 
 (
  [accountId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Role]

CREATE TABLE [dbo].[Role]
(
 [id]   int IDENTITY (1, 1) NOT NULL ,
 [role] nvarchar(25) NOT NULL ,


 CONSTRAINT [PKC_Role] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[AccountRole]

CREATE TABLE [dbo].[AccountRole]
(
 [roleId]    int NOT NULL ,
 [accountId] int NOT NULL ,


 CONSTRAINT [FK_Role_id__AccountRole_roleId] FOREIGN KEY ([roleId])  REFERENCES [dbo].[Role]([id]),
 CONSTRAINT [FK_Account_id__AccountRole_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_AccountRole_roleId] ON [dbo].[AccountRole] 
 (
  [roleId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_AccountRole_accountId] ON [dbo].[AccountRole] 
 (
  [accountId] ASC
 )

GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[ActivityLog]

CREATE TABLE [dbo].[ActivityLog]
(
 [id]          int IDENTITY (1, 1) NOT NULL ,
 [username]    nvarchar(25) NOT NULL ,
 [type]        nvarchar(50) NOT NULL ,
 [createdAt]   datetime NOT NULL ,
 [description] nvarchar(max) NOT NULL ,
 [data]        nvarchar(max) NOT NULL ,


 CONSTRAINT [PKC_ActivityLog] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Country]

CREATE TABLE [dbo].[Country]
(
 [id]       int IDENTITY (1,1) NOT NULL,
 [iso2]     nvarchar(2) NOT NULL ,
 [name]     nvarchar(255) NOT NULL ,


 CONSTRAINT [PKC_Country] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [UK_Country_iso2] UNIQUE ([iso2])
);
GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[State]

CREATE TABLE [dbo].[State]
(
 [id]        int IDENTITY (1, 1) NOT NULL ,
 [name]      nvarchar(255) NOT NULL ,
 [countryId] int NOT NULL ,


 CONSTRAINT [PKC_State] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Country_id__State_countryId] FOREIGN KEY ([countryId])  REFERENCES [dbo].[Country]([id])
);
GO

CREATE NONCLUSTERED INDEX [FKNCIX_State_countryId] ON [dbo].[State] 
 (
  [countryId] ASC
 )

GO



-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[City]

CREATE TABLE [dbo].[City]
(
 [id]      int IDENTITY (1, 1) NOT NULL ,
 [name]    nvarchar(255) NOT NULL ,
 [stateId] int NOT NULL ,


 CONSTRAINT [PKC_City] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_State_id__City_stateId] FOREIGN KEY ([stateId])  REFERENCES [dbo].[State]([id])
);
GO

CREATE NONCLUSTERED INDEX [FKNCIX_City_stateId] ON [dbo].[City] 
 (
  [stateId] ASC
 )

GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Address]

CREATE TABLE [dbo].[Address]
(
 [id]                 int IDENTITY (1, 1) NOT NULL ,
 [streetAddressLine1] nvarchar(255) NOT NULL ,
 [streetAddressLine2] nvarchar(255) NOT NULL ,
 [zip]                nvarchar(9) NULL ,
 [coordinates]        nvarchar(255) NULL ,
 [cityId]             int NOT NULL ,
 [stateId]            int NOT NULL ,
 [countryId]          int NOT NULL ,
 [accountId]          int NOT NULL ,


 CONSTRAINT [PKC_Address] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_City_id__Address_cityId] FOREIGN KEY ([cityId])  REFERENCES [dbo].[City]([id]),
 CONSTRAINT [FK_State_id__Address_stateId] FOREIGN KEY ([stateId])  REFERENCES [dbo].[State]([id]),
 CONSTRAINT [FK_Country_id__Address_countryId] FOREIGN KEY ([countryId])  REFERENCES [dbo].[Country]([id]),
 CONSTRAINT [FK_Account_id__Address_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FCNCIX_Address_cityId] ON [dbo].[Address] 
 (
  [cityId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FCNCIX_Address_stateId] ON [dbo].[Address] 
 (
  [stateId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FCNCIX_Address_countryId] ON [dbo].[Address] 
 (
  [countryId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FCNCIX_Address_accountId] ON [dbo].[Address] 
 (
  [accountId] ASC
 )

GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[AuthType]

CREATE TABLE [dbo].[AuthType]
(
 [id]   int IDENTITY (1, 1) NOT NULL ,
 [type] nvarchar(25) NOT NULL ,


 CONSTRAINT [PKC_AuthType] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[AuthLog]

CREATE TABLE [dbo].[AuthLog]
(
 [id]         int IDENTITY (1, 1) NOT NULL ,
 [platform]   nvarchar(255) NULL ,
 [browser]    nvarchar(255) NULL ,
 [ip]         nvarchar(255) NULL ,
 [createdAt]  datetime NOT NULL ,
 [authTypeId] int NOT NULL ,
 [accountId]  int NOT NULL ,


 CONSTRAINT [PKC_AuthLog] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_AuthLog_authTypeId__AuthType_id] FOREIGN KEY ([authTypeId])  REFERENCES [dbo].[AuthType]([id]),
 CONSTRAINT [FK_AuthLog_accountId__Account_id] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_AuthLog_authTypeId] ON [dbo].[AuthLog] 
 (
  [authTypeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_AuthLog_AccountId] ON [dbo].[AuthLog] 
 (
  [accountId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Business]

CREATE TABLE [dbo].[Business]
(
 [id]            int IDENTITY (1, 1) NOT NULL ,
 [name]          nvarchar(255) NOT NULL ,
 [accountTypeId] int NOT NULL ,
 [accountId]     int NOT NULL ,


 CONSTRAINT [PKC_Business] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__Business__accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Business_accountTypeId] ON [dbo].[Business] 
 (
  [accountTypeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_Business_accountId] ON [dbo].[Business] 
 (
  [accountId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Person]

CREATE TABLE [dbo].[Person]
(
 [id]            int IDENTITY (1, 1) NOT NULL ,
 [name]          nvarchar(255) NOT NULL ,
 [surname]       nvarchar(255) NOT NULL ,
 [gender]        nvarchar(25) NOT NULL ,
 [dob]           date NOT NULL ,
 [accountTypeId] int NOT NULL ,
 [accountId]     int NOT NULL ,


 CONSTRAINT [PKC_Person] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__Person_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Person_accountTypeId] ON [dbo].[Person] 
 (
  [accountTypeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_Person_accountId] ON [dbo].[Person] 
 (
  [accountId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Customer]

CREATE TABLE [dbo].[Customer]
(
 [id]              int IDENTITY (1, 1) NOT NULL ,
 [accountId]       int NOT NULL ,
 [name]            nvarchar(255) NOT NULL ,
 [surname]         nvarchar(255) NOT NULL ,
 [gender]          nvarchar(25) NULL ,
 [dob]             date NOT NULL ,
 [accountTypeId]   int NOT NULL ,
 [profilePhotoUrl] nvarchar(max) NULL ,


 CONSTRAINT [PKC_Customer] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__Customer_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Customer_accountId] ON [dbo].[Customer] 
 (
  [accountId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_Customer_accountTypeId] ON [dbo].[Customer] 
 (
  [accountTypeId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Employee]

CREATE TABLE [dbo].[Employee]
(
 [id]           int IDENTITY (1, 1) NOT NULL ,
 [name]         nvarchar(255) NOT NULL ,
 [surname]      nvarchar(255) NOT NULL ,
 [position]     nvarchar(255) NOT NULL ,
 [username]     nvarchar(25) NOT NULL ,
 [password]     nvarchar(255) NOT NULL ,
 [hiredOn]      date NOT NULL ,
 [firedOn]      date NULL ,
 [contractType] nvarchar(25) NOT NULL ,
 [salary]       money NOT NULL ,
 [accountId]    int NOT NULL ,


 CONSTRAINT [PKC_Employee] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__Employee_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Employee_accountId] ON [dbo].[Employee] 
 (
  [accountId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[EmployeeRole]

CREATE TABLE [dbo].[EmployeeRole]
(
 [id]   int IDENTITY (1, 1) NOT NULL ,
 [role] nvarchar(25) NOT NULL ,


 CONSTRAINT [PKC_EmployeeRole_id] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[EmployeeAccountRole]

CREATE TABLE [dbo].[EmployeeAccountRole]
(
 [employeeId]     int NOT NULL ,
 [employeeRoleId] int NOT NULL ,


 CONSTRAINT [FK_EmployeeAccountRole_employeeId__Employee_id] FOREIGN KEY ([employeeId])  REFERENCES [dbo].[Employee]([id]),
 CONSTRAINT [FK_EmployeeAccountRole_employeeRoleId__EmployeeRole_id] FOREIGN KEY ([employeeRoleId])  REFERENCES [dbo].[EmployeeRole]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeAccountRole_employeeId] ON [dbo].[EmployeeAccountRole] 
 (
  [employeeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeAccountRole_employeeRoleId] ON [dbo].[EmployeeAccountRole] 
 (
  [employeeRoleId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[EmployeeAddress]

CREATE TABLE [dbo].[EmployeeAddress]
(
 [id]                 int IDENTITY (1, 1) NOT NULL ,
 [streetAddressLine1] nvarchar(255) NOT NULL ,
 [streetAddressLine2] nvarchar(255) NOT NULL ,
 [zip]                nvarchar(9) NULL ,
 [coordinates]        nvarchar(255) NULL ,
 [cityId]             int NOT NULL ,
 [stateId]            int NOT NULL ,
 [countryId]          int NOT NULL ,
 [employeeId]         int NOT NULL ,


 CONSTRAINT [PKC_EmployeeAddress_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Employee_id__EmployeeAddress_employeeId] FOREIGN KEY ([employeeId])  REFERENCES [dbo].[Employee]([id]),
 CONSTRAINT [FK_City_id__EmployeeAddress_cityId] FOREIGN KEY ([cityId])  REFERENCES [dbo].[City]([id]),
 CONSTRAINT [FK_State_id__EmployeeAddress_stateId] FOREIGN KEY ([stateId])  REFERENCES [dbo].[State]([id]),
 CONSTRAINT [FK_Country_id__EmployeeAddress_countryId] FOREIGN KEY ([countryId])  REFERENCES [dbo].[Country]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeAddress_employeeId] ON [dbo].[EmployeeAddress] 
 (
  [employeeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeAddress_cityId] ON [dbo].[EmployeeAddress] 
 (
  [cityId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeAddress_stateId] ON [dbo].[EmployeeAddress] 
 (
  [stateId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeAddress_countryId] ON [dbo].[EmployeeAddress] 
 (
  [countryId] ASC
 )

GO






-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[EmployeeAuthLog]

CREATE TABLE [dbo].[EmployeeAuthLog]
(
 [id]             int IDENTITY (1, 1) NOT NULL ,
 [platform]       nvarchar(255) NULL ,
 [browser]        nvarchar(255) NULL ,
 [ip]             nvarchar(255) NULL ,
 [createdAt]      datetime NOT NULL ,
 [authTypeId]     int NOT NULL ,
 [employeeAuthId] int NOT NULL ,


 CONSTRAINT [PKC_EmployeeAuthLog_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_AuthType_id__EmployeeAuthLog_authTypeId] FOREIGN KEY ([authTypeId])  REFERENCES [dbo].[AuthType]([id]),
 CONSTRAINT [FK_Employee_id__EmployeeAuthLog_employeeAuthId] FOREIGN KEY ([employeeAuthId])  REFERENCES [dbo].[Employee]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeAuthLog_authTypeId] ON [dbo].[EmployeeAuthLog] 
 (
  [authTypeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeAuthLog_employeeAuthId] ON [dbo].[EmployeeAuthLog] 
 (
  [employeeAuthId] ASC
 )

GO






-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[EmployeeEmail]

CREATE TABLE [dbo].[EmployeeEmail]
(
 [id]         int IDENTITY (1, 1) NOT NULL ,
 [email]      nvarchar(255) NOT NULL ,
 [type]       nvarchar(25) NULL ,
 [employeeId] int NOT NULL ,


 CONSTRAINT [PKC_EmployeeEmail] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Employee_id__EmployeeEmail_employeeId] FOREIGN KEY ([employeeId])  REFERENCES [dbo].[Employee]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeEmail_employeeId] ON [dbo].[EmployeeEmail] 
 (
  [employeeId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[EmployeePhoneNumber]

CREATE TABLE [dbo].[EmployeePhoneNumber]
(
 [id]          int IDENTITY (1, 1) NOT NULL ,
 [phoneNumber] nvarchar(25) NOT NULL ,
 [type]        nvarchar(25) NULL ,
 [employeeId]  int NOT NULL ,


 CONSTRAINT [PKC_PhoneNumber_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Employee_id__EmployeePhoneNumber_employeeId] FOREIGN KEY ([employeeId])  REFERENCES [dbo].[Employee]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_EmployeePhoneNumber_employeeId] ON [dbo].[EmployeePhoneNumber] 
 (
  [employeeId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[EmployeeFile]

CREATE TABLE [dbo].[EmployeeFile]
(
 [id]         int IDENTITY (1, 1) NOT NULL ,
 [employeeid] int NOT NULL ,
 [name]       nvarchar(255) NOT NULL ,
 [createdAt]  datetime NOT NULL ,
 [url]        nvarchar(max) NOT NULL ,


 CONSTRAINT [PKC_EmloyeeFile_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Employee_id__EmployeeFile_employeeId] FOREIGN KEY ([employeeid])  REFERENCES [dbo].[Employee]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeFile_employeeId] ON [dbo].[EmployeeFile] 
 (
  [employeeid] ASC
 )

GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[EmployeeTag]

CREATE TABLE [dbo].[EmployeeTag]
(
 [id]  int IDENTITY (1, 1) NOT NULL ,
 [tag] nvarchar(255) NULL ,


 CONSTRAINT [PKC_EmployeeTag_id] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[EmployeeFileTag]

CREATE TABLE [dbo].[EmployeeFileTag]
(
 [employeeFileId] int NOT NULL ,
 [employeeTagId]  int NOT NULL ,


 CONSTRAINT [FK_EmployeeFile_id__EmployeeFileTag_employeeFileId] FOREIGN KEY ([employeeFileId])  REFERENCES [dbo].[EmployeeFile]([id]),
 CONSTRAINT [FK_EmployeeTag_id__EmployeeFileTag_employeeTag_id] FOREIGN KEY ([employeeTagId])  REFERENCES [dbo].[EmployeeTag]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeFileTag_employeeFileId] ON [dbo].[EmployeeFileTag] 
 (
  [employeeFileId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_EmployeeFileTag_employeeTagId] ON [dbo].[EmployeeFileTag] 
 (
  [employeeTagId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[File]

CREATE TABLE [dbo].[File]
(
 [id]        int IDENTITY (1, 1) NOT NULL ,
 [name]      nvarchar(1000) NOT NULL ,
 [accountId] int NOT NULL ,
 [author]    nvarchar(255) NOT NULL ,
 [createdAt] datetime NOT NULL ,
 [url]       nvarchar(max) NOT NULL ,


 CONSTRAINT [PKC_File_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__File_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_File_accountId] ON [dbo].[File] 
 (
  [accountId] ASC
 )

GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Tag]

CREATE TABLE [dbo].[Tag]
(
 [id]  int IDENTITY (1, 1) NOT NULL ,
 [tag] nvarchar(255) NOT NULL ,


 CONSTRAINT [PKC_FileTag] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[FileTag]

CREATE TABLE [dbo].[FileTag]
(
 [fileId] int NOT NULL ,
 [tagId]  int NOT NULL ,


 CONSTRAINT [FK_File_id__FileTag_fileId] FOREIGN KEY ([fileId])  REFERENCES [dbo].[File]([id]),
 CONSTRAINT [FK_Tag_id__FileTag_tagId] FOREIGN KEY ([tagId])  REFERENCES [dbo].[Tag]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_FileTag_fileId] ON [dbo].[FileTag] 
 (
  [fileId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_FileTag_tagId] ON [dbo].[FileTag] 
 (
  [tagId] ASC
 )

GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[IdentificationDocument]

CREATE TABLE [dbo].[IdentificationDocument]
(
 [id]                     int IDENTITY (1, 1) NOT NULL ,
 [identificationDocument] nvarchar(255) NOT NULL ,
 [type]                   nvarchar(255) NOT NULL ,
 [accountId]              int NOT NULL ,


 CONSTRAINT [PKC_IdentificationCocument_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__IdentificationDocument_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_IdentificationDocument_accountId] ON [dbo].[IdentificationDocument] 
 (
  [accountId] ASC
 )

GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[InventoryItemBoxDimension]

CREATE TABLE [dbo].[InventoryItemBoxDimension]
(
 [id]         int IDENTITY (1, 1) NOT NULL ,
 [height]     int NOT NULL ,
 [heightUnit] nvarchar(25) NOT NULL ,
 [width]      int NOT NULL ,
 [widthUnit]  nvarchar(25) NOT NULL ,
 [depth]      int NOT NULL ,
 [depthUnit]  nvarchar(25) NOT NULL ,


 CONSTRAINT [PKC_InventoryItemBox] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO






-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[ItemCategory]

CREATE TABLE [dbo].[ItemCategory]
(
 [id]       int IDENTITY (1, 1) NOT NULL ,
 [category] nvarchar(255) NOT NULL ,


 CONSTRAINT [PKC_ItemCategory_id] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[InventoryItem]

CREATE TABLE [dbo].[InventoryItem]
(
 [id]                     int IDENTITY (1, 1) NOT NULL ,
 [name]                   nvarchar(255) NOT NULL ,
 [description]            nvarchar(max) NULL ,
 [brand]                  nvarchar(255) NOT NULL ,
 [partNumber]             nvarchar(255) NOT NULL ,
 [model]                  nvarchar(255) NULL ,
 [unitQuantityWithoutBox] int NULL ,
 [unitQuantity]           int NULL ,
 [unitsPerBox]            int NULL ,
 [boxQuantity]            int NULL ,
 [expiration]             datetime NULL ,
 [elaboration]            datetime NULL ,
 [listedOn]               datetime NOT NULL ,
 [productCode]            nvarchar(25) NOT NULL ,
 [boxDimensionId]         int NULL ,
 [accountId]              int NOT NULL ,
 [employeeId]             int NOT NULL ,
 [categoryId]             int NULL ,


 CONSTRAINT [PKC_InventoryItem_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_InventoryItemDimensionBox_id__InventoryItem_boxDimensionId] FOREIGN KEY ([boxDimensionId])  REFERENCES [dbo].[InventoryItemBoxDimension]([id]),
 CONSTRAINT [FK_Account_id__InventoryItem_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id]),
 CONSTRAINT [FK_Employee_id__InventoryItem_employeeId] FOREIGN KEY ([employeeId])  REFERENCES [dbo].[Employee]([id]),
 CONSTRAINT [FK_ItemCategory_id__InventoryItem_categoryId] FOREIGN KEY ([categoryId])  REFERENCES [dbo].[ItemCategory]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_InventoryItem_boxDimensionId] ON [dbo].[InventoryItem] 
 (
  [boxDimensionId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_InventoryItem_accountId] ON [dbo].[InventoryItem] 
 (
  [accountId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_InventoryItem_employeeId] ON [dbo].[InventoryItem] 
 (
  [employeeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_InventoryItem_categoryId] ON [dbo].[InventoryItem] 
 (
  [categoryId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[InventoryItemFile]

CREATE TABLE [dbo].[InventoryItemFile]
(
 [id]              int IDENTITY (1, 1) NOT NULL ,
 [name]            nvarchar(1000) NOT NULL ,
 [author]          nvarchar(255) NOT NULL ,
 [createdAt]       datetime NOT NULL ,
 [inventoryItemId] int NOT NULL ,
 [url]             nvarchar(max) NOT NULL ,


 CONSTRAINT [PKC_InventoryItemFile_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_InventoryItem_id__InventoryItemFile_inventoryItemId] FOREIGN KEY ([inventoryItemId])  REFERENCES [dbo].[InventoryItem]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_InventoryItemFile_inventoryItemId] ON [dbo].[InventoryItemFile] 
 (
  [inventoryItemId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Supplier]

CREATE TABLE [dbo].[Supplier]
(
 [id]        int IDENTITY (1, 1) NOT NULL ,
 [name]      nvarchar(255) NOT NULL ,
 [accountId] int NOT NULL ,


 CONSTRAINT [PKC_Supplier_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__Supplier_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Supplier_accountId] ON [dbo].[Supplier] 
 (
  [accountId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[SupplierAddress]

CREATE TABLE [dbo].[SupplierAddress]
(
 [id]                 int IDENTITY (1, 1) NOT NULL ,
 [streetAddressLine1] nvarchar(255) NOT NULL ,
 [streetAddressLine2] nvarchar(255) NOT NULL ,
 [zip]                nvarchar(9) NULL ,
 [coordinates]        nvarchar(255) NULL ,
 [cityId]             int NOT NULL ,
 [stateId]            int NOT NULL ,
 [countryId]          int NOT NULL ,
 [supplierId]         int NOT NULL ,


 CONSTRAINT [PKC_SupplierAddress_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Supplier_id__SupplierAddress_supplierId] FOREIGN KEY ([supplierId])  REFERENCES [dbo].[Supplier]([id]),
 CONSTRAINT [FK_City_id__SupplierAddress_cityId] FOREIGN KEY ([cityId])  REFERENCES [dbo].[City]([id]),
 CONSTRAINT [FK_State_id__SupplierAddress_stateId] FOREIGN KEY ([stateId])  REFERENCES [dbo].[State]([id]),
 CONSTRAINT [FK_Country_id__SupplierAddress_countryId] FOREIGN KEY ([countryId])  REFERENCES [dbo].[Country]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_SupplierAddress_supplierId] ON [dbo].[SupplierAddress] 
 (
  [supplierId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_SupplierAddress_cityId] ON [dbo].[SupplierAddress] 
 (
  [cityId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_SupplierAddress_stateId] ON [dbo].[SupplierAddress] 
 (
  [stateId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_SupplierAddress_countryId] ON [dbo].[SupplierAddress] 
 (
  [countryId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[SupplierContact]

CREATE TABLE [dbo].[SupplierContact]
(
 [id]         int IDENTITY (1, 1) NOT NULL ,
 [name]       nvarchar(255) NOT NULL ,
 [supplierId] int NOT NULL ,


 CONSTRAINT [PKC_SupplierContact_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Supplier_id__SupplierContact_supplier_id] FOREIGN KEY ([supplierId])  REFERENCES [dbo].[Supplier]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_SupplierContact_supplierId] ON [dbo].[SupplierContact] 
 (
  [supplierId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[SupplierEmail]

CREATE TABLE [dbo].[SupplierEmail]
(
 [id]                int IDENTITY (1, 1) NOT NULL ,
 [email]             nvarchar(255) NOT NULL ,
 [type]              nvarchar(25) NULL ,
 [supplierContactId] int NOT NULL ,


 CONSTRAINT [PKC_SupplierEmail_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_SupplierContact_id__SupplierEmail_supplierContactId] FOREIGN KEY ([supplierContactId])  REFERENCES [dbo].[SupplierContact]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_SupplierEmail_supplierContactId] ON [dbo].[SupplierEmail] 
 (
  [supplierContactId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[SupplierPhoneNumber]

CREATE TABLE [dbo].[SupplierPhoneNumber]
(
 [id]                    int IDENTITY (1, 1) NOT NULL ,
 [phoneNumber]           nvarchar(25) NOT NULL ,
 [type]                  nvarchar(25) NULL ,
 [supplierPhoneNumberId] int NOT NULL ,


 CONSTRAINT [PKC_SupplierPhoneNumber_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_SupplierContact_id__SupplierPhoneNumber_supplierPhoneNumberId] FOREIGN KEY ([supplierPhoneNumberId])  REFERENCES [dbo].[SupplierContact]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_SupplierPhoneNumber_supplierPhoneNumberId] ON [dbo].[SupplierPhoneNumber] 
 (
  [supplierPhoneNumberId] ASC
 )

GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[InventoryItemSupplier]

CREATE TABLE [dbo].[InventoryItemSupplier]
(
 [supplierId]      int NOT NULL ,
 [inventoryItemId] int NOT NULL ,


 CONSTRAINT [FK_Supplier_id__InventoryItemSupplier_supplierId] FOREIGN KEY ([supplierId])  REFERENCES [dbo].[Supplier]([id]),
 CONSTRAINT [FK_InventoryItem_id__InventoryItemSupplier_inventoryItemId] FOREIGN KEY ([inventoryItemId])  REFERENCES [dbo].[InventoryItem]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_InventoryItemSupplier_supplierId] ON [dbo].[InventoryItemSupplier] 
 (
  [supplierId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_InventoryItemSupplier_inventoryItemId] ON [dbo].[InventoryItemSupplier] 
 (
  [inventoryItemId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Warehouse]

CREATE TABLE [dbo].[Warehouse]
(
 [id]        int IDENTITY (1, 1) NOT NULL ,
 [name]      nvarchar(255) NOT NULL ,
 [accountId] int NOT NULL ,


 CONSTRAINT [PKC_Warehouse_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__Warehouse_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Warehouse_accountId] ON [dbo].[Warehouse] 
 (
  [accountId] ASC
 )

GO






-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[WarehouseAddress]

CREATE TABLE [dbo].[WarehouseAddress]
(
 [id]                 int NOT NULL ,
 [streetAddressLine1] nvarchar(255) NOT NULL ,
 [streetAddressLine2] nvarchar(255) NOT NULL ,
 [zip]                nvarchar(9) NULL ,
 [coordinates]        nvarchar(255) NULL ,
 [cityId]             int NOT NULL ,
 [stateId]            int NOT NULL ,
 [countryId]          int NOT NULL ,
 [warehouseId]        int NOT NULL ,


 CONSTRAINT [PKC_WarehouseAddress_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Warehouse_id__WarehouseAddress_warehouseId] FOREIGN KEY ([warehouseId])  REFERENCES [dbo].[Warehouse]([id]),
 CONSTRAINT [FK_City_id__WarehouseAddress_cityId] FOREIGN KEY ([cityId])  REFERENCES [dbo].[City]([id]),
 CONSTRAINT [FK_State_id__WarehouseAddress_stateId] FOREIGN KEY ([stateId])  REFERENCES [dbo].[State]([id]),
 CONSTRAINT [FK_Country_id__WarehouseAddress_countryId] FOREIGN KEY ([countryId])  REFERENCES [dbo].[Country]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_WarehouseAddress_warehouseId] ON [dbo].[WarehouseAddress] 
 (
  [warehouseId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_WarehouseAddress_cityId] ON [dbo].[WarehouseAddress] 
 (
  [cityId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_WarehouseAddress_stateId] ON [dbo].[WarehouseAddress] 
 (
  [stateId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_WarehouseAddress_countryId] ON [dbo].[WarehouseAddress] 
 (
  [countryId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[WarehouseEmployee]

CREATE TABLE [dbo].[WarehouseEmployee]
(
 [employeeId]  int NOT NULL ,
 [warehouseId] int NOT NULL ,


 CONSTRAINT [FK_Employee_id__WarehouseEmployee_employeeId] FOREIGN KEY ([employeeId])  REFERENCES [dbo].[Employee]([id]),
 CONSTRAINT [FK_Warehouse_id__WarehouseEmployee_warehouseId] FOREIGN KEY ([warehouseId])  REFERENCES [dbo].[Warehouse]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_WarehouseEmployee_employeeId] ON [dbo].[WarehouseEmployee] 
 (
  [employeeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_WarehouseEmployee_warehouseId] ON [dbo].[WarehouseEmployee] 
 (
  [warehouseId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[WarehouseFile]

CREATE TABLE [dbo].[WarehouseFile]
(
 [id]          int IDENTITY (1, 1) NOT NULL ,
 [name]        nvarchar(1000) NOT NULL ,
 [createdAt]   datetime NOT NULL ,
 [warehouseId] int NOT NULL ,
 [url]         nvarchar(max) NOT NULL ,


 CONSTRAINT [PKC_WarehouseFile_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Warehouse_id__WarehouseFile_warehouseId] FOREIGN KEY ([warehouseId])  REFERENCES [dbo].[Warehouse]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_WarehouseFile_warehouseID] ON [dbo].[WarehouseFile] 
 (
  [warehouseId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[WarehouseTag]

CREATE TABLE [dbo].[WarehouseTag]
(
 [id]  int IDENTITY (1, 1) NOT NULL ,
 [tag] nvarchar(255) NULL ,


 CONSTRAINT [PKC_WarehouseTag_id] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[WarehouseFileTag]

CREATE TABLE [dbo].[WarehouseFileTag]
(
 [warehouseFileId] int NOT NULL ,
 [warehouseTagId]  int NOT NULL ,


 CONSTRAINT [FK_WarehouseFile_id__WarehouseFileTag_warehouseFileId] FOREIGN KEY ([warehouseFileId])  REFERENCES [dbo].[WarehouseFile]([id]),
 CONSTRAINT [FK_WarehouseTag_id__WarehouseFileTag_warehouseTagId] FOREIGN KEY ([warehouseTagId])  REFERENCES [dbo].[WarehouseTag]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_WarehouseFileTag_warehouseFileId] ON [dbo].[WarehouseFileTag] 
 (
  [warehouseFileId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_WarehouseFileTag_warehouseTagId] ON [dbo].[WarehouseFileTag] 
 (
  [warehouseTagId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Store]

CREATE TABLE [dbo].[Store]
(
 [id]        int IDENTITY (1, 1) NOT NULL ,
 [accountId] int NOT NULL ,
 [name]      nvarchar(255) NOT NULL ,


 CONSTRAINT [PKC_Store_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__Store_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Store_accountId] ON [dbo].[Store] 
 (
  [accountId] ASC
 )

GO







-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[StoreAddress]

CREATE TABLE [dbo].[StoreAddress]
(
 [id]                 int IDENTITY (1, 1) NOT NULL ,
 [streetAddressLine1] nvarchar(255) NOT NULL ,
 [streetAddressLine2] nvarchar(255) NOT NULL ,
 [zip]                nvarchar(9) NULL ,
 [coordinates]        nvarchar(255) NULL ,
 [cityId]             int NOT NULL ,
 [stateId]            int NOT NULL ,
 [countryId]          int NOT NULL ,
 [storeId]            int NOT NULL ,


 CONSTRAINT [PKC_StoreAddress_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Store_id__StoreAddress_storeId] FOREIGN KEY ([storeId])  REFERENCES [dbo].[Store]([id]),
 CONSTRAINT [FK_City_id__StoreAddress_cityId] FOREIGN KEY ([cityId])  REFERENCES [dbo].[City]([id]),
 CONSTRAINT [FK_State_id__StoreAddress_stateId] FOREIGN KEY ([stateId])  REFERENCES [dbo].[State]([id]),
 CONSTRAINT [FK_Country_id__StoreAddress_countryId] FOREIGN KEY ([countryId])  REFERENCES [dbo].[Country]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_StoreAddress_storeId] ON [dbo].[StoreAddress] 
 (
  [storeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_StoreAddress_cityId] ON [dbo].[StoreAddress] 
 (
  [cityId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_StoreAddress_stateId] ON [dbo].[StoreAddress] 
 (
  [stateId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_StoreAddress_countryId] ON [dbo].[StoreAddress] 
 (
  [countryId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[ConsumerItem]

CREATE TABLE [dbo].[ConsumerItem]
(
 [id]                     int IDENTITY (1, 1) NOT NULL ,
 [inventoryItemId]          int NOT NULL ,
 [listedOnStore]          datetime NOT NULL ,
 [soldOn]                 datetime NULL ,
 [price]                  money NOT NULL ,
 [discount]               int NULL ,
 [description]            nvarchar(max) NULL ,
 [boxQuantity]            int NULL ,
 [unitsPerBox]            int NULL ,
 [unitQuantityWithoutBox] int NULL ,
 [unitQuantity]           int NOT NULL ,


 CONSTRAINT [PKC_ConsumerItem_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_InventoryItem_id__ConsumerItem_inventoryItemId] FOREIGN KEY ([inventoryItemId])  REFERENCES [dbo].[InventoryItem]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_ConsumerItem_inventoryItemIx] ON [dbo].[ConsumerItem] 
 (
  [inventoryItemId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[StoreConsumerItem]

CREATE TABLE [dbo].[StoreConsumerItem]
(
 [storeId]        int NOT NULL ,
 [consumerItemId] int NOT NULL ,


 CONSTRAINT [FK_Store_id__StoreConsumerItem_storeId] FOREIGN KEY ([storeId])  REFERENCES [dbo].[Store]([id]),
 CONSTRAINT [FK_ConsumerItem_id__StoreConsumerItem_consumerItemId] FOREIGN KEY ([consumerItemId])  REFERENCES [dbo].[ConsumerItem]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_StoreConsumerItem_storeId] ON [dbo].[StoreConsumerItem] 
 (
  [storeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_StoreConsumerItem_consumerItemId] ON [dbo].[StoreConsumerItem] 
 (
  [consumerItemId] ASC
 )

GO







-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[StoreEmail]

CREATE TABLE [dbo].[StoreEmail]
(
 [id]      int IDENTITY (1, 1) NOT NULL ,
 [email]   nvarchar(255) NOT NULL ,
 [storeId] int NOT NULL ,


 CONSTRAINT [PKC_Email_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Store_id__StoreEmail_storeId] FOREIGN KEY ([storeId])  REFERENCES [dbo].[Store]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_StoreEmail_storeId] ON [dbo].[StoreEmail] 
 (
  [storeId] ASC
 )

GO







-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[StoreEmployee]

CREATE TABLE [dbo].[StoreEmployee]
(
 [employeeId] int NOT NULL ,
 [storeId]    int NOT NULL ,


 CONSTRAINT [FK_Employee_id__StoreEmployee_employeeId] FOREIGN KEY ([employeeId])  REFERENCES [dbo].[Employee]([id]),
 CONSTRAINT [FK_Store_id__StoreEmpployee_storeId] FOREIGN KEY ([storeId])  REFERENCES [dbo].[Store]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_StoreEmployee_employeeId] ON [dbo].[StoreEmployee] 
 (
  [employeeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_StoreEmployee_storeId] ON [dbo].[StoreEmployee] 
 (
  [storeId] ASC
 )

GO







-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[StorePhoneNumber]

CREATE TABLE [dbo].[StorePhoneNumber]
(
 [id]          int IDENTITY (1, 1) NOT NULL ,
 [phoneNumber] nvarchar(25) NOT NULL ,
 [storeId]     int NOT NULL ,


 CONSTRAINT [PKC_StorePhoneNumber_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Store_id__StorePhoneNumber_storeId] FOREIGN KEY ([storeId])  REFERENCES [dbo].[Store]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_StorePhoneNumber_storeId] ON [dbo].[StorePhoneNumber] 
 (
  [storeId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[WarehouseInventory]

CREATE TABLE [dbo].[WarehouseInventory]
(
 [warehouseId]     int NOT NULL ,
 [inventoryItemId] int NOT NULL ,


 CONSTRAINT [FK_Warehouse_id__WarehouseInventory_warehouseId] FOREIGN KEY ([warehouseId])  REFERENCES [dbo].[Warehouse]([id]),
 CONSTRAINT [FK_InventoryItem_id__WarehouseInventory_inventoryItemId] FOREIGN KEY ([inventoryItemId])  REFERENCES [dbo].[InventoryItem]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_WarehouseInventory_warehouseId] ON [dbo].[WarehouseInventory] 
 (
  [warehouseId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_WarehouseInventory_inventoryItemId] ON [dbo].[WarehouseInventory] 
 (
  [inventoryItemId] ASC
 )

GO






-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[WarehousePhoneNumber]

CREATE TABLE [dbo].[WarehousePhoneNumber]
(
 [id]          int IDENTITY (1, 1) NOT NULL ,
 [phoneNumber] nvarchar(25) NOT NULL ,
 [type]        nvarchar(25) NOT NULL ,
 [warehouseId] int NOT NULL ,


 CONSTRAINT [PKC_WarehousePhoneNumber_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Warehouse_id__WarehousePhoneNumber_warehouseID] FOREIGN KEY ([warehouseId])  REFERENCES [dbo].[Warehouse]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_WarehousePhoneNumber_warehouseId] ON [dbo].[WarehousePhoneNumber] 
 (
  [warehouseId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Sale]

CREATE TABLE [dbo].[Sale]
(
 [customerId]     int NOT NULL ,
 [consumerItemId] int NOT NULL ,
 [storeId]        int NOT NULL ,
 [createdAt]      datetime NOT NULL ,
 [accountId]      int NOT NULL ,
 [total]          money NOT NULL ,
 [tax]            int NOT NULL ,
 [beforeTax]      money NOT NULL ,


 CONSTRAINT [FK_Customer_id__Sale_customerId] FOREIGN KEY ([customerId])  REFERENCES [dbo].[Customer]([id]),
 CONSTRAINT [FK_ConsumerItem_id__Sale_consumerItemId] FOREIGN KEY ([consumerItemId])  REFERENCES [dbo].[ConsumerItem]([id]),
 CONSTRAINT [FK_Store_id__Sale_storeId] FOREIGN KEY ([storeId])  REFERENCES [dbo].[Store]([id]),
 CONSTRAINT [FK_Account_id__Sale_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Sale_customerId] ON [dbo].[Sale] 
 (
  [customerId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_Sale_consumerItemId] ON [dbo].[Sale] 
 (
  [consumerItemId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_Sale_storeId] ON [dbo].[Sale] 
 (
  [storeId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_Sale_accountId] ON [dbo].[Sale] 
 (
  [accountId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Quote]

CREATE TABLE [dbo].[Quote]
(
 [id]           int IDENTITY (1, 1) NOT NULL ,
 [createdAt]    datetime NOT NULL ,
 [validThrough] datetime NOT NULL ,
 [customerId]   int NOT NULL ,


 CONSTRAINT [PKC_Quote_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Customer_id__Quote_customerId] FOREIGN KEY ([customerId])  REFERENCES [dbo].[Customer]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Quote_customerId] ON [dbo].[Quote] 
 (
  [customerId] ASC
 )

GO




-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[ConsumerItemQuote]

CREATE TABLE [dbo].[ConsumerItemQuote]
(
 [quoteId] int NOT NULL ,
 [consumerItemId]      int NOT NULL ,


 CONSTRAINT [FK_Quote_id__ConsumerItemQuote_quoteId] FOREIGN KEY ([quoteId])  REFERENCES [dbo].[Quote]([id]),
 CONSTRAINT [FK_ConsumerItem_id__ConsumerItemQuote_consumerItemId] FOREIGN KEY ([consumerItemId])  REFERENCES [dbo].[ConsumerItem]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_ConsumerItemQuote_quoteId] ON [dbo].[ConsumerItemQuote] 
 (
  [quoteId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_ConsumerItemQuote_consumerItemId] ON [dbo].[ConsumerItemQuote] 
 (
  [consumerItemId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[PurchaseOrder]

CREATE TABLE [dbo].[PurchaseOrder]
(
 [id]               int IDENTITY (1, 1) NOT NULL ,
 [createdAt]        datetime NOT NULL ,
 [accountId]        int NOT NULL ,
 [deliveryLocation] nvarchar(255) NOT NULL ,
 [total]            money NOT NULL ,
 [tax]              int NOT NULL ,
 [beforeTax]        money NOT NULL ,


 CONSTRAINT [PKC_PurchaseOrder_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Account_id__PurchaseOrder_accountId] FOREIGN KEY ([accountId])  REFERENCES [dbo].[Account]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_PurchaseOrder_accountId] ON [dbo].[PurchaseOrder] 
 (
  [accountId] ASC
 )

GO






-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[PurchaseOrderItems]

CREATE TABLE [dbo].[PurchaseOrderItems]
(
 [id]              int IDENTITY (1, 1) NOT NULL ,
 [purchaseOrderId] int NOT NULL ,
 [productCode]     nvarchar(25) NOT NULL ,
 [quantity]        int NOT NULL ,
 [quantityUnit]    nvarchar(25) NOT NULL ,
 [price]           money NOT NULL ,


 CONSTRAINT [PKC_PurchaseOrderItems_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_PurchaseOrder_id__PurchaseOrderItems_purchaseOrderId] FOREIGN KEY ([purchaseOrderId])  REFERENCES [dbo].[PurchaseOrder]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_PurchaseOrderItems_purcahseOrderId] ON [dbo].[PurchaseOrderItems] 
 (
  [purchaseOrderId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Aisle]

CREATE TABLE [dbo].[Aisle]
(
 [id]    int IDENTITY (1, 1) NOT NULL ,
 [asile] nvarchar(10) NOT NULL ,


 CONSTRAINT [PKC_Aisle_id] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Shelf]

CREATE TABLE [dbo].[Shelf]
(
 [id]      int IDENTITY (1, 1) NOT NULL ,
 [shelf]   nvarchar(10) NOT NULL ,
 [aisleId] int NOT NULL ,


 CONSTRAINT [PKC_Shelf_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Aisle_id__Shelf_aisleId] FOREIGN KEY ([aisleId])  REFERENCES [dbo].[Aisle]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Shelf_aisleId] ON [dbo].[Shelf] 
 (
  [aisleId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Bay]

CREATE TABLE [dbo].[Bay]
(
 [id]      int IDENTITY (1, 1) NOT NULL ,
 [bay]     nvarchar(10) NOT NULL ,
 [shelfId] int NOT NULL ,


 CONSTRAINT [PKC_Bay_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Shelf_id__Bay_shelfId] FOREIGN KEY ([shelfId])  REFERENCES [dbo].[Shelf]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Bay_shelfId] ON [dbo].[Bay] 
 (
  [shelfId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[Bin]

CREATE TABLE [dbo].[Bin]
(
 [id]    int IDENTITY (1, 1) NOT NULL ,
 [bin]   nvarchar(10) NOT NULL ,
 [bayId] int NOT NULL ,


 CONSTRAINT [PK_Bin_id] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_Bay_id__Bin__bayId] FOREIGN KEY ([bayId])  REFERENCES [dbo].[Bay]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_Bin_bayId] ON [dbo].[Bin] 
 (
  [bayId] ASC
 )

GO





-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [dbo].[StorageLocation]

CREATE TABLE [dbo].[StorageLocation]
(
 [aisleId]         int NOT NULL ,
 [inventoryItemId] int NOT NULL ,


 CONSTRAINT [FK_Aisle_id__StorageLocation_aisleId] FOREIGN KEY ([aisleId])  REFERENCES [dbo].[Aisle]([id]),
 CONSTRAINT [FK_InventoryItem_id__StorageLocation_inventoryItemId] FOREIGN KEY ([inventoryItemId])  REFERENCES [dbo].[InventoryItem]([id])
);
GO


CREATE NONCLUSTERED INDEX [FKNCIX_StorageLocation_aisleId] ON [dbo].[StorageLocation] 
 (
  [aisleId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [FKNCIX_StorageLocation_inventoryItemId] ON [dbo].[StorageLocation] 
 (
  [inventoryItemId] ASC
 )

GO