CREATE DATABASE crimes;
-- create database

USE crimes; 
-- access database

SELECT * 
FROM crimes_us;
-- first look at the table imported

SELECT COUNT(*) 
FROM crimes_us;
-- number of records

SHOW FIELDS 
FROM crimes_us;
-- fields data type

SELECT COUNT(*) 
FROM crimes_us;
-- number of records

SELECT COUNT(DISTINCT Category) 
FROM crimes_us;
-- number of categories of crimes performed

SELECT COUNT(DISTINCT Description) 
FROM crimes_us;
-- number of subcategories (description) of crimes performed

SELECT Category, Description, COUNT(*) AS TimesPerformed
FROM crimes_us 
GROUP BY Category, Description 
ORDER BY Category, Description;
-- times the specific crime has been performed ordered alphabetically

SELECT Category, COUNT(*) AS TimesPerformed
FROM crimes_us 
GROUP BY Category
ORDER BY TimesPerformed DESC;
-- times the category crime was performed ordered from the most repeated to the less

SELECT Category, Arrest, Domestic, COUNT(*) AS Sanctioned
FROM crimes_us
WHERE Arrest = "TRUE" OR Domestic = "TRUE"
GROUP BY Category 
ORDER BY Sanctioned DESC;
-- times an specific category criminal has received any sanction (arrest or domestic arrest)

SELECT Category, Arrest, Domestic, COUNT(*) AS NotSanctioned
FROM crimes_us
WHERE Arrest = "FALSE" AND Domestic = "FALSE"
GROUP BY Category 
ORDER BY NotSanctioned DESC;
-- times an specific category criminal didn't received any sanction (arrest or domestic arrest)

SELECT CASE
         WHEN GROUPING (Category) = 1 THEN 'Total'
         ELSE (Category)
       END Category,
       COUNT(*) AS TimesSanctioned
FROM   crimes_us
WHERE Arrest = "TRUE" OR Domestic = "TRUE"
GROUP  BY Category WITH ROLLUP;
-- similar as previous one with Total row added at the end

SELECT Category, Description, COUNT(*) AS TimesPerformedInDecember
FROM crimes_us
WHERE Month = 12
GROUP BY Description
ORDER BY TimesPerformedInDecember DESC;
-- times a category crime (by description) was performed in December 2022

SELECT Category, Description, Ward, CommunityArea, COUNT(*) AS TimesPerArea
FROM crimes_us
GROUP BY CommunityArea
ORDER BY TimesPerArea DESC;
-- to cross-check with other database with area codes (TO DO)
-- retrieves the ward and community area code where the crimes were performed
-- grouped by community area as it is smaller than a ward

SELECT Category, Ward, Location, COUNT(*) AS TimesPerformed
FROM crimes_us
GROUP BY Location
ORDER BY TimesPerformed DESC;
-- times a category crime was performed per location (street, apartment, residence, etc) in descending order

SELECT Block, Category, COUNT(*) AS Times
FROM crimes_us
GROUP BY Block
ORDER BY Times DESC
LIMIT 20;
-- 20 most dangerous blocks, category of crimes, and times they were performed