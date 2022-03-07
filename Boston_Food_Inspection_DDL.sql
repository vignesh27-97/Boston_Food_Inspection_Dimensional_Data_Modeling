-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- BostonFoodInspection.dbo.Dim_Address definition

-- Drop table

-- DROP TABLE BostonFoodInspection.dbo.Dim_Address;

CREATE TABLE BostonFoodInspection.dbo.Dim_Address (
	Addr_SK int NOT NULL,
	Property_ID int NULL,
	Addr_State varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Addr_City varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Addr_Zip varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Addr varchar(5000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Longitude varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Latitude varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Dim_Addr__7EBE3315A762FD2A PRIMARY KEY (Addr_SK)
);


-- BostonFoodInspection.dbo.Dim_Business definition

-- Drop table

-- DROP TABLE BostonFoodInspection.dbo.Dim_Business;

CREATE TABLE BostonFoodInspection.dbo.Dim_Business (
	Business_SK int NOT NULL,
	BusinessName varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LegalOwner varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Descript varchar(5000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Dim_Busi__3AA02B1A75308A85 PRIMARY KEY (Business_SK)
);


-- BostonFoodInspection.dbo.Dim_Date definition

-- Drop table

-- DROP TABLE BostonFoodInspection.dbo.Dim_Date;

CREATE TABLE BostonFoodInspection.dbo.Dim_Date (
	Date_Key int NOT NULL,
	Date_Year int NULL,
	Date_Month varchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Date_Day varchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	FullDate datetime2 NULL,
	CONSTRAINT Dim_Date_PK PRIMARY KEY (Date_Key)
);


-- BostonFoodInspection.dbo.Dim_Owner definition

-- Drop table

-- DROP TABLE BostonFoodInspection.dbo.Dim_Owner;

CREATE TABLE BostonFoodInspection.dbo.Dim_Owner (
	Owner_SK int NOT NULL,
	NameFirst varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	NameLast varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Dim_Owne__BD60E5DEE1FC6C7D PRIMARY KEY (Owner_SK)
);


-- BostonFoodInspection.dbo.Dim_License definition

-- Drop table

-- DROP TABLE BostonFoodInspection.dbo.Dim_License;

CREATE TABLE BostonFoodInspection.dbo.Dim_License (
	LicenseNo int NOT NULL,
	LicStatus varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IssDttm int NULL,
	ExpDttm int NULL,
	LicenseCat varchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Dim_Lice__72D7E8715152B26F PRIMARY KEY (LicenseNo),
	CONSTRAINT Exp_Date_FK FOREIGN KEY (ExpDttm) REFERENCES BostonFoodInspection.dbo.Dim_Date(Date_Key),
	CONSTRAINT Issue_Date_FK FOREIGN KEY (IssDttm) REFERENCES BostonFoodInspection.dbo.Dim_Date(Date_Key)
);
ALTER TABLE BostonFoodInspection.dbo.Dim_License WITH NOCHECK ADD CONSTRAINT Chk_Status CHECK ([LicStatus]='Deleted' OR [LicStatus]='Inactive' OR [LicStatus]='Active');


-- BostonFoodInspection.dbo.Dim_Violation definition

-- Drop table

-- DROP TABLE BostonFoodInspection.dbo.Dim_Violation;

CREATE TABLE BostonFoodInspection.dbo.Dim_Violation (
	Violation_SK int NOT NULL,
	Violation varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ViolLevel varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ViolDesc varchar(5000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ViolDttm int NULL,
	ViolStatus varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Dim_Viol__DDDF246F77525FB4 PRIMARY KEY (Violation_SK),
	CONSTRAINT Dim_Violation_FK FOREIGN KEY (ViolDttm) REFERENCES BostonFoodInspection.dbo.Dim_Date(Date_Key)
);


-- BostonFoodInspection.dbo.Fact_Inspection definition

-- Drop table

-- DROP TABLE BostonFoodInspection.dbo.Fact_Inspection;

CREATE TABLE BostonFoodInspection.dbo.Fact_Inspection (
	Owner_SK int NULL,
	LicenseNo int NULL,
	Business_SK int NULL,
	Violation_SK int NULL,
	Addr_SK int NULL,
	StatusDate int NULL,
	ResultDttm int NULL,
	[Result] varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Comments varchar(5000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Inspection_SK int NOT NULL,
	CONSTRAINT Fact_Inspection_PK PRIMARY KEY (Inspection_SK),
	CONSTRAINT Addr_FK FOREIGN KEY (Addr_SK) REFERENCES BostonFoodInspection.dbo.Dim_Address(Addr_SK),
	CONSTRAINT Business_FK FOREIGN KEY (Business_SK) REFERENCES BostonFoodInspection.dbo.Dim_Business(Business_SK),
	CONSTRAINT Fact_Inspection_FK FOREIGN KEY (LicenseNo) REFERENCES BostonFoodInspection.dbo.Dim_License(LicenseNo),
	CONSTRAINT Fact_License_key_FK FOREIGN KEY (LicenseNo) REFERENCES BostonFoodInspection.dbo.Dim_License(LicenseNo),
	CONSTRAINT License_Key_FK FOREIGN KEY (LicenseNo) REFERENCES BostonFoodInspection.dbo.Dim_License(LicenseNo),
	CONSTRAINT Owner_FK FOREIGN KEY (Owner_SK) REFERENCES BostonFoodInspection.dbo.Dim_Owner(Owner_SK),
	CONSTRAINT Resukt_Date_FK FOREIGN KEY (ResultDttm) REFERENCES BostonFoodInspection.dbo.Dim_Date(Date_Key),
	CONSTRAINT Status_Date_FK FOREIGN KEY (StatusDate) REFERENCES BostonFoodInspection.dbo.Dim_Date(Date_Key),
	CONSTRAINT Viol_FK FOREIGN KEY (Violation_SK) REFERENCES BostonFoodInspection.dbo.Dim_Violation(Violation_SK)
);
