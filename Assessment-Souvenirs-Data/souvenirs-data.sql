use Souvenir;
GO

/* select * from Souvenir */
/* select * from [souvenirs-denormalized] */

/* select * from Category  */
/* DELETE FROM Category
   DBCC CHECKIDENT ('Souvenir.dbo.Category',RESEED, 0) */
insert into Category (CategoryName)
    select distinct Category 
    from [souvenirs-denormalized];

/* select * from [Owner] */
/* DELETE FROM [Owner]
   DBCC CHECKIDENT ('Souvenir.dbo.Owner',RESEED, 0) */
insert into [Owner] (OwnerGroup)
    select distinct [Owner] 
    from [souvenirs-denormalized];

/* select * from [Location] */
/* DELETE FROM [Location]
   DBCC CHECKIDENT ('Souvenir.dbo.Location',RESEED, 0) */
insert into [Location] (Longitude,Latitude,City,Region,Country,NonPhysical)
    select distinct Longitude, Latitude, City, Region, Country, case 
        when Latitude is null and City is null
        then 1
        else 0
        end
    from [souvenirs-denormalized];

/* select * from Souvenir */
/* truncate table Souvenir */
insert into Souvenir ([SouvenirName],SouvenirDesc,[Weight],DateObtained,Price,LocationID,OwnerID,CategoryID)
    select distinct sd.Souvenir_Name,sd.Souvenir_Description,sd.[Weight],sd.DateObtained,sd.Price,
    case 
        when l.LocationID is null
        then 1
        else l.LocationID
        end,
    o.OwnerID,c.CategoryID 
    from [souvenirs-denormalized] sd
    left join Souvenir s on sd.[Weight] = s.Weight
    inner join [Owner] o on sd.[Owner] = o.OwnerGroup
    inner join Category c on sd.Category = c.CategoryName
    left join [Location] l on sd.City = l.City or sd.Longitude = l.Longitude;

DROP TABLE [dbo].[souvenirs-denormalized];

insert into Category (CategoryName) 
    values ('Video Games');
insert into Category (CategoryName) 
    values ('Musical Instruments'); 

/* select * from Category  */

update Souvenir set 
    CategoryID = 12
where LocationID = 1

/* select * from Souvenir s 
inner join Category c on s.CategoryID = c.CategoryID 
inner join [Location] l on s.LocationID = l.LocationID
where s.LocationID = 1 */

update Souvenir set 
    CategoryID = 8
where SouvenirName like '%Jewelry Box%'

/* select * from Souvenir s 
inner join Category c on s.CategoryID = c.CategoryID 
where SouvenirName like '%Jewelry Box%' */

update Souvenir set 
    CategoryID = 13
where SouvenirName in ('Shamisen', 'Egyptian Drum', 'Zuffolo')

/* select * from Souvenir s 
inner join Category c on s.CategoryID = c.CategoryID 
where SouvenirName in ('Shamisen', 'Egyptian Drum', 'Zuffolo') */


delete from Souvenir
where [Weight] in (select max([Weight]) from Souvenir)

/* select max([Weight]) from Souvenir */


delete from Souvenir
where SouvenirName like '%dirt%' or SouvenirName like '%sand%'

/* select SouvenirName from Souvenir where SouvenirName like '%dirt%' or SouvenirName like '%sand%' */









