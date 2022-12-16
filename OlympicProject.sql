SELECT *
FROM Projects.dbo.athlete_events



--Let's look at the earliest year the Olympics were recorded

SELECT MIN(Year)
FROM Projects.dbo.athlete_events

--When was the first winter games

SELECT MIN(Year)
FROM Projects.dbo.athlete_events
WHERE Season = 'Winter'


--Now let's look at how many individuals have competed

SELECT COUNT (DISTINCT ID) AS DistinctCompetitors
FROM Projects.dbo.athlete_events


--Which individual has competed in the most events in the Summer and Winter Olympics


SELECT DISTINCT (ID), Name, NOC, COUNT (ID) OVER (PARTITION BY ID) AS TotalEventsCompetedSummer
FROM Projects.dbo.athlete_events
WHERE Season = 'Summer'
ORDER BY TotalEventsCompetedSummer DESC




SELECT DISTINCT (ID), Name, NOC, COUNT (Name) OVER (PARTITION BY ID) AS TotalEventsCompetedWinter
FROM Projects.dbo.athlete_events
WHERE Season = 'Winter' 
ORDER BY TotalEventsCompetedWinter DESC


--Now, which individuals have won the most medals

--Summer

SELECT DISTINCT (ID), Name, NOC, COUNT (ID) OVER (PARTITION BY ID) AS IndividualMedalCountSummer
FROM athlete_events
WHERE Medal <> 'NA' AND Season = 'Summer'
ORDER BY IndividualMedalCountSummer DESC

--Winter

SELECT DISTINCT (ID), Name, NOC, COUNT (ID) OVER (PARTITION BY ID) AS IndividualMedalCountWinter
FROM athlete_events
WHERE Medal <> 'NA' AND Season = 'Winter'
ORDER BY IndividualMedalCountWinter DESC

--Most total male Gold medals

SELECT ID, Name, NOC, Season, COUNT (Medal) AS MensGoldMedalCount
FROM athlete_events
WHERE Medal = 'Gold' AND Sex = 'M'
GROUP BY ID, Name, NOC, Season
ORDER BY MensGoldMedalCount DESC, ID, Name


--Most total female Gold medals

SELECT ID, Name, NOC, Season, COUNT (Medal) AS FemaleGoldMedalCount
FROM athlete_events
WHERE Medal = 'Gold' AND Sex = 'F'
GROUP BY ID, Name, NOC, Season
ORDER BY FemaleGoldMedalCount DESC, ID, Name


--Which countries had the most medals

SELECT NOC, COUNT (Medal) AS TotalMedalsCountry
FROM athlete_events
WHERE Medal <> 'NA'
GROUP BY NOC
ORDER BY TotalMedalsCountry DESC


--Summer

SELECT NOC, COUNT (Medal) AS SummerMedalsCountry
FROM athlete_events
WHERE Medal <> 'NA' AND Season = 'Summer'
GROUP BY NOC
ORDER BY SummerMedalsCountry DESC

--Winter

SELECT NOC, COUNT (Medal) AS WinterMedalsCountry
FROM athlete_events
WHERE Medal <> 'NA' AND Season = 'Winter'
GROUP BY NOC
ORDER BY WinterMedalsCountry DESC


--Most Gold medals for each country

SELECT NOC, COUNT (Medal) AS GoldMedalsCountry
FROM athlete_events
WHERE Medal = 'Gold'
GROUP BY NOC
ORDER BY GoldMedalsCountry DESC

--Summer

SELECT NOC, COUNT (Medal) AS SummerGoldMedalsCountry
FROM athlete_events
WHERE Medal = 'Gold' AND Season = 'Summer'
GROUP BY NOC
ORDER BY SummerGoldMedalsCountry DESC

--Winter

SELECT NOC, COUNT (Medal) AS WinterGoldMedalsCountry
FROM athlete_events
WHERE Medal = 'Gold' AND Season = 'Winter'
GROUP BY NOC
ORDER BY WinterGoldMedalsCountry DESC


--Tallest and shortest competitors

SELECT Name, Sex, NOC, Games, Height
FROM athlete_events
WHERE Height is not null
GROUP BY Name, Sex, NOC, Games, Height
ORDER BY Height 


SELECT Name, Sex, NOC, Games, Height
FROM athlete_events
WHERE Height is not null
GROUP BY Name, Sex, NOC, Games, Height
ORDER BY Height DESC


--Oldest and youngest competitors

SELECT Min(Age) AS YoungestCompetitor
FROM athlete_events

SELECT Name, Sex, Age, NOC, Games, Event, Medal
FROM athlete_events
WHERE Age is not null
ORDER BY Age 


SELECT Max(Age) AS OldestCompetitor
FROM athlete_events

SELECT Name, Sex, Age, NOC, Games, Event, Medal
FROM athlete_events
WHERE Age is not null
ORDER BY Age DESC 


--Youngest and Oldest to medal

SELECT Name, Sex, Age, NOC, Games, Event, Medal
FROM athlete_events
WHERE Age is not null AND Medal <> 'NA'
ORDER BY Age  


SELECT Name, Sex, Age, NOC, Games, Event, Medal
FROM athlete_events
WHERE Age is not null AND Medal <> 'NA'
ORDER BY Age DESC 