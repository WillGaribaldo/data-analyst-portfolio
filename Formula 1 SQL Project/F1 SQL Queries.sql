-- 1. Which nationalities have the most wins?
SELECT d.nationality, COUNT(*) AS total_wins
FROM results r
JOIN drivers d ON r.driverId = d.driverId
WHERE r.position = 1
GROUP BY d.nationality
ORDER By 2 DESC

-- 2. Which nationalities have the most F1 drivers?
SELECT d.nationality, COUNT(*) AS total_wins
FROM drivers d
GROUP BY d.nationality
ORDER By 2 DESC

-- 3. What age do F1 drivers have the most wins?
SELECT DATEDIFF(YEAR, dbo.drivers.dob, dbo.races.date) AS Age, COUNT(dbo.results.raceid) AS Wins
FROM dbo.results
inner join dbo.drivers ON dbo.results.driverId=dbo.drivers.driverId
inner join dbo.races ON dbo.results.raceid=dbo.races.raceid
WHERE position = 1
Group by DATEDIFF(YEAR, dbo.drivers.dob, dbo.races.date) 
order by wins DESC

-- 4. What season in their career do F1 drivers have the most wins?
With firstSeason as (
	SELECT re.driverId, dr.forename, ra.year AS season1 
		FROM (
			SELECT re.driverId, re.raceId, re.position, ra.year, ROW_NUMBER() OVER (PARTITION BY re.driverId ORDER BY ra.year ) AS row_num
			FROM dbo.results re
			JOIN dbo.races AS ra ON re.raceId = ra.raceId
			) AS re
JOIN dbo.races AS ra ON re.raceId = ra.raceId
JOIN dbo.drivers AS dr ON re.driverId = dr.driverId
WHERE re.row_num = 1
)
,
Winners as (
SELECT 
	re.driverId, ra.year AS Won_year
FROM dbo.results re
JOIN dbo.races AS ra ON re.raceId = ra.raceId
WHERE 
	re.position = 1 
)
SELECT 
	(wi.Won_year - fs.season1) AS Season_in_f1,
	COUNT(*) total_wins
    FROM
	firstSeason fs
    JOIN winners wi ON fs.driverid = wi.driverid
    GROUP BY 
	(wi.won_year - fs.season1)
    ORDER BY 
    total_wins DESC

-- 5. Which country have hosted the most races?
SELECT c.country, COUNT(*) AS Races
FROM dbo.circuits c
JOIN
dbo.races r ON c.circuitId = r.circuitId
GROUP BY c.country
ORDER By 2 DESC