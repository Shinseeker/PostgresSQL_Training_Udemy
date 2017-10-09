/*
  tb.sql & p3.sql
*/
DROP TABLE IF EXISTS tb;
DROP TABLE IF EXISTS population;

CREATE TABLE tb 
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  sex varchar(6) NOT NULL,
  child int NULL,
  adult int NULL,
  elderly int NULL
);

LOAD DATA LOCAL INFILE 'C:/Users/jake/Desktop/tb.csv' 
INTO TABLE tb
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(country, year, sex, @child, @adult, @elderly)
SET
child = nullif(@child,-1),
adult = nullif(@adult,-1),
elderly = nullif(@elderly,-1)
;

SELECT * FROM tb WHERE elderly IS NULL;
SELECT COUNT(*) FROM tb;
CREATE TABLE population
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  population int NULL
);

LOAD DATA LOCAL INFILE 'C:/Users/jake/Desktop/population.csv' 
INTO TABLE population
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(country, year, population);

SELECT p.country AS country, p.year AS year, ((t.child+t.adult+t.elderly) / p.population) AS rate
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/tb_rates.xls'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
FROM population AS p
LEFT JOIN tb AS t
ON p.country = t.country
AND p.year = t.year
GROUP BY p.country, p.year, rate
HAVING rate IS NOT NULL
ORDER BY country, year;