SELECT carrier, AVG(arr_delay), month
INTO OUTFILE 'C:/rProgramData/MySQL/MySQL Server 5.7/Uploads/flights_project42.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
FROM flights
WHERE month = 1
OR month = 7
GROUP BY carrier, year, month
ORDER BY carrier;