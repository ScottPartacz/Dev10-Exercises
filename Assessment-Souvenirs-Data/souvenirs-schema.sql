use master; 
GO
drop database if exists Souvenir;
GO
create database Souvenir;
GO
use Souvenir;
GO

create table Category (
    CategoryID int primary key identity(1,1),
    CategoryName varchar(20)
);

create table OwnerGroup (
    OwnerGroupID int primary key identity(1,1),
    OwnerGroup varchar(30)
);

create table [Permissions] (
    PermissionID int primary key identity(1,1),
    PermissionTag int
);

create table [Owner] (
    OwnerID int primary key identity(1,1),
    OwnerName varchar(100),
    Username varchar(50),
    [Password] varchar(50),
    PermissionID int,
    OwnerGroupID int,
    constraint fk_Owner_PermissionID
        foreign key (PermissionID)
        references [Permissions](PermissionID),
    constraint fk_Owner_OwnerGroupID
        foreign key (OwnerGroupID)
        references OwnerGroup(OwnerGroupID)
);

create table [Location] (
    LocationID int primary key identity(1,1),
    Longitude float,
    Latitude float,
    City varchar(50),
    Region varchar(50),
    Country varchar (50),
    NonPhysical bit not null,
    /* Constraint to check that there is either a lat and long location or all three (Country,Region,City) or its nonPhysical */
    constraint ck_nulllocation
        check (((Longitude is not null) and (Latitude is not null)) 
        or ((City is not null) and (Country is not null) and (Region is not null))
        or NonPhysical = 1
        ),
    constraint uq_latitude_longitude
        unique (Latitude,Longitude,City,Region,Country,NonPhysical)
);


create table Souvenir (
    SouvenirID int primary key identity(1,1),
    SouvenirName varchar(200),
    SouvenirDesc varchar(200),
    [Weight] int,
    DateObtained date not null,
    Price float not null,
    LocationID int,
    OwnerID int,
    CategoryID int,
    constraint fk_Souvenir_LocationID
        foreign key (LocationID)
        references [Location](LocationID),
    constraint fk_Souvenir_OwnerID
        foreign key (OwnerID)
        references [Owner](OwnerID),
    constraint fk_Souvenir_CategoryID
        foreign key (CategoryID)
        references Category(CategoryID)    
);
