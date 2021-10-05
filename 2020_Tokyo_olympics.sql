--QUERYING ALL DATA AND LIMITING TOP 10--

SELECT TOP(10) *
FROM olympics_2020_data
ORDER BY Name;

--HOW MANY MEDALS EARNED FROM EACH TEAM?--

SELECT TOP(10) Team,
COUNT(CASE Medal WHEN 'Gold' THEN 1 END) Gold, 
COUNT(CASE Medal WHEN 'Silver' THEN 1 END) Silver,
COUNT(CASE Medal WHEN 'Bronze' THEN 1 END) Bronze
FROM olympics_2020_data
GROUP BY Team
ORDER BY Gold DESC,Silver DESC,Bronze DESC;

--HOW MANY MANY FEMALE ATHLETES?--

SELECT COUNT(Sex) AS Female_Athletes
FROM olympics_2020_data
WHERE Sex = 'F';

--HOW MANY MANY MALE ATHLETES?--

SELECT COUNT(Sex) AS Female_Athletes
FROM olympics_2020_data
WHERE Sex = 'M';

--NUMBER OF MALES VS FEMALE ATHLETES

SELECT COUNT(CASE WHEN Sex = 'M' THEN 1 END) Male, COUNT(CASE WHEN Sex = 'F' THEN 1 END) Female
FROM olympics_2020_data;

--PERCENTAGE OF FEMALE ATHLETES--

SELECT 100 * CAST(COUNT(CASE WHEN Sex = 'F' THEN 1 END) AS FLOAT) / COUNT(*) AS Percenage_of_Females
FROM olympics_2020_data;

--PERCENTAGE OF MALE ATHLETES--

SELECT 100 * CAST(COUNT(CASE WHEN Sex = 'M' THEN 1 END) AS FLOAT) / COUNT(*) AS Percenage_of_Males
FROM olympics_2020_data;

--NUMBER OF FEMALE ATHLETES THAT WON A MEDAL--

SELECT COUNT(Sex) AS Female_Medal_Winners, (SELECT COUNT(Sex) FROM olympics_2020_data WHERE Sex = 'F') AS Female_Athletes
FROM olympics_2020_data
WHERE Sex = 'F' AND Medal IN ('Gold','Silver','Bronze');

--NUMBER OF MALE ATHLTES THAT WON A MEDAL--

SELECT COUNT(Sex) AS Male_Medal_Winners, (SELECT COUNT(Sex) FROM olympics_2020_data WHERE Sex = 'M') AS Male_Athletes
FROM olympics_2020_data
WHERE Sex = 'M' AND Medal IN ('Gold','Silver','Bronze');

--PERCENTAGE OF FEMALE ATHLETES THAT WON A MEDAL--

SELECT 100 * COUNT(Sex) / (SELECT COUNT(Sex) FROM olympics_2020_data WHERE Sex = 'F') AS Percentage_Female_Medal
FROM olympics_2020_data
WHERE Sex = 'F' AND Medal IN ('Gold','Silver','Bronze');

--PERCENTAGE OF MALE ATHLETES THAT WON A MEDAL--

SELECT 100 * COUNT(Sex) / (SELECT COUNT(Sex) FROM olympics_2020_data WHERE Sex = 'M') AS Percentage_Male_Medal
FROM olympics_2020_data
WHERE Sex = 'M' AND Medal IN ('Gold','Silver','Bronze');

--WHAT IS THE AVERAGE AGE OF FEMALE/MALE ATHELETE--

SELECT AVG(CAST(Age AS INT)) as Average_Female_Age
FROM olympics_2020_data
WHERE Sex = 'F';

SELECT AVG(CAST(Age AS INT)) as Average_Male_Age
FROM olympics_2020_data
WHERE Sex = 'M';

--Who is the youngest/oldest athletes?--

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
