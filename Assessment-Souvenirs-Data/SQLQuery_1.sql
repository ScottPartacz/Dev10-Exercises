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

create table [Owner] (
    OwnerID int primary key identity(1,1),
    OwnerGroup varchar(20)
);

create table [Location] (
    LocationID int primary key identity(1,1),
    Longitude float,
    Lattitude float,
    City varchar(20),
    Region varchar(20),
    Country varchar (20),
    NonPhysical bit not null,
    constraint ck_nulllocation
        check (((Longitude is not null) and (Lattitude is not null)) 
        or ((City is not null) and (Country is not null) and (Region is not null))
        or NonPhysical = 1
        )
);

create table Souvenir (
    SouvenirID int primary key identity(1,1),
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
