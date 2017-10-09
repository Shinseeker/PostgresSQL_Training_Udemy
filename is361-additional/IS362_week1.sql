-- How many airplanes have listed speeds?
-- What is the maximum listed speed and the maximum listed speed?
-- What is the minimum listed speed and the maximum listed speed?

SELECT
COUNT(speed) as NumWSpeed,
MAX(speed) AS MaxSpeed,
MIN(speed) AS MinSpeed
FROM planes;

-- What is the total distance flown by all of the planes in January 2013?

SELECT
SUM(distance) as TotalMiles
FROM flights
WHERE (month = 1) AND (year = 2013);

-- What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?
SELECT
SUM(distance) as NullMiles
FROM flights
WHERE (month = 1) AND (year = 2013) AND (tailnum is NULL);

-- What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? 
-- Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN. 
-- How do your results compare?
-- INNER JOIN does not show NULL miles while LEFT OUTER JOIN does

SELECT 
SUM(distance) AS TotalMiles,
p.manufacturer
FROM flights f
INNER  JOIN planes p
ON f.tailnum = p.tailnum
WHERE (f.year = 2013) AND (f.month = 7) AND (f.day = 5)
GROUP BY p.manufacturer;

SELECT 
SUM(distance) AS TotalMiles,
p.manufacturer
FROM flights f
LEFT OUTER JOIN planes p
ON f.tailnum = p.tailnum
WHERE (f.year = 2013) AND (f.month = 7) AND (f.day = 5)
GROUP BY p.manufacturer;

-- Write and answer at least one question of your own choosing that joins information 
-- from at least three of the tables in the flights database.

-- How many models of planes per airline flew into each destination in August 2013?

SELECT 
COUNT(f.tailnum), p.model, a.name, dest
FROM flights f
LEFT JOIN planes p ON f.tailnum = p.tailnum
LEFT JOIN airlines a ON f.carrier = a.carrier
WHERE (f.year = 2013) AND (f.month = 8)
GROUP BY f.dest, a.name, p.model
