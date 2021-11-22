/* select * from Souvenir where categoryID = 10 */

/* 1 */
Select top 3 * from Souvenir
order by Price ;

Select top 7 * from Souvenir
order by Price desc;

/* 2 */
Select * from Souvenir
where SouvenirName like '%mug%'
order by [Weight] desc;

/* 3 */
Select count(SouvenirID) as NumberofSpoons from Souvenir
where SouvenirName like '%spoon%'; 

/* 4 */
Select avg([Weight]) as AverageWeight, min([Weight]) as MinimumWeight, max([Weight]) as MaximumWeight,CategoryName
from Souvenir s
inner join Category c on s.CategoryID = c.CategoryID
group by CategoryName;

/* 5 */
/* CategoryID = 7 */

select SouvenirName,l.City,l.Country,l.Region,l.Latitude,l.Longitude  
from Souvenir s
inner join [Location] l on s.LocationID = l.LocationID
where CategoryID = 7;

/* 6 */
Select  o.OwnerGroup, min(DateObtained) as EarliestDate , max(DateObtained) as LatestDate
from Souvenir s
inner join [Owner] o on s.OwnerID = o.OwnerID
group by OwnerGroup
order by EarliestDate;

/* 7 */
declare @populardate date;
declare @numberoftimes int;
select top 1 @populardate = DateObtained ,@numberoftimes = count(DateObtained) from Souvenir
group by DateObtained
order by count(DateObtained)  desc; 

select SouvenirName from Souvenir
where DateObtained = @populardate;

/* 8 */
Select SouvenirName from Souvenir s
inner join [Location] l on s.LocationID = l.LocationID
where longitude is null and latitude is null;

/* 9 */
Select SouvenirName from Souvenir s
inner join [Location] l on s.LocationID = l.LocationID
where city is null and region is null and country is null;

/* 10 */
Select SouvenirName,City,Region,Country,Latitude,Longitude,[Weight] 
from Souvenir s
inner join [Location] l on s.LocationID = l.LocationID
where [Weight] > (select avg([Weight]) from Souvenir);

/* 11 */
Select max(Price) as HighestPrice, min(Price) as LowestPrice,CategoryName
from Souvenir s
inner join Category c on s.CategoryID = c.CategoryID
group by CategoryName;