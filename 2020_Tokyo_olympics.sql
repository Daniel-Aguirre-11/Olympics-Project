--QUERYING ALL DATA AND LIMITING TOP 10

SELECT TOP(10) *
FROM olympics_2020_data
ORDER BY Name;

--MEDALS EARNED FROM EACH TEAM?

SELECT TOP(10) Team,
COUNT(CASE Medal WHEN 'Gold' THEN 1 END) Gold, 
COUNT(CASE Medal WHEN 'Silver' THEN 1 END) Silver,
COUNT(CASE Medal WHEN 'Bronze' THEN 1 END) Bronze
FROM olympics_2020_data
GROUP BY Team
ORDER BY Gold DESC,Silver DESC,Bronze DESC;

--IN WHICH SPORT DID EACH COUNTRY EARN THE MOST GOLD MEDALS?

SELECT Sport, Team, Gold_Medals_won
FROM (SELECT RANK() OVER(PARTITION BY Sport ORDER BY Sport, COUNT(*) DESC) AS Rank, Sport, Team, COUNT(*) AS Gold_Medals_won
	  FROM olympics_2020_data
	  WHERE Medal = 'Gold'
	  GROUP BY Sport, Team) tmp
WHERE Rank = 1
ORDER BY Gold_Medals_won DESC;

--COUNT OF MALE VS FEMALE ATHLETES?

SELECT Sex, COUNT(*) AS Amount
FROM olympics_2020_data
GROUP BY Sex;

--PERCENTAGE OF MALE VS FEMALE ATHLETES

SELECT FORMAT(CAST(COUNT(CASE WHEN Sex = 'M' THEN 1 END) AS FLOAT) / COUNT(*), 'P') AS Percenage_of_Males,
	   FORMAT(CAST(COUNT(CASE WHEN Sex = 'F' THEN 1 END) AS FLOAT) / COUNT(*), 'P') AS Percenage_of_Females
FROM olympics_2020_data;

--NUMBER OF FEMALE ATHLETES THAT WON A MEDAL

SELECT COUNT(*) AS Female_Medal_Winners, (SELECT COUNT(*) FROM olympics_2020_data WHERE Sex = 'F') AS Total_Female_Athletes
FROM olympics_2020_data
WHERE Sex = 'F' AND Medal IN ('Gold','Silver','Bronze');

--NUMBER OF MALE ATHLETES THAT WON A MEDAL

SELECT COUNT(*) AS Male_Medal_Winners, (SELECT COUNT(*) FROM olympics_2020_data WHERE Sex = 'M') AS Total_Male_Athletes
FROM olympics_2020_data
WHERE Sex = 'M' AND Medal IN ('Gold','Silver','Bronze');

--PERCENTAGE OF FEMALE ATHLETES THAT WON A MEDAL

SELECT 100 * COUNT(Sex) / (SELECT COUNT(Sex) FROM olympics_2020_data WHERE Sex = 'F') AS Percentage_Female_Medal
FROM olympics_2020_data
WHERE Sex = 'F' AND Medal IN ('Gold','Silver','Bronze');

--PERCENTAGE OF MALE ATHLETES THAT WON A MEDAL

SELECT 100 * COUNT(*) / (SELECT COUNT(*) FROM olympics_2020_data WHERE Sex = 'M') AS Percentage_Male_Medal
FROM olympics_2020_data
WHERE Sex = 'M' AND Medal IN ('Gold','Silver','Bronze');

--WHAT IS THE AVERAGE AGE OF FEMALE/MALE ATHELETE

SELECT Sex, AVG(CAST(Age AS INT)) AS Avg_age
FROM olympics_2020_data
GROUP BY Sex;

--Who are the youngest/oldest athletes?

SELECT *
FROM olympics_2020_data
WHERE Age IN 
(
	SELECT MIN(Age)
	FROM olympics_2020_data
);

SELECT *
FROM olympics_2020_data
WHERE Age IN 
(
	SELECT MAX(Age)
	FROM olympics_2020_data
);

--average age for of athletes in each sport along with total number of athletes?

SELECT Sport, AVG(CAST(Age AS INT)) Avg_age, COUNT(*) Total_athletes
FROM olympics_2020_data
GROUP BY Sport
ORDER BY AVG(CAST(Age AS INT));

--male vs female

SELECT Sport, AVG(CASE Sex WHEN 'M' THEN CAST(Age AS INT) END) Avg_Male_age, COUNT(CASE Sex WHEN 'M' THEN 1 END) Total_male,
	   AVG(CASE Sex WHEN 'F' THEN CAST(Age AS INT) END) Avg_Female_age, COUNT(CASE Sex WHEN 'F' THEN 1 END) Total_female
FROM olympics_2020_data
GROUP BY Sport
ORDER BY AVG(CAST(Age AS INT));
