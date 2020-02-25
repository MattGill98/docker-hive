DROP TABLE temp;
CREATE TABLE temp
(station string, time string, report string, source string, dailyweather string, hourlyaltimetersetting string, hourlydewpointtemperature string, hourlydrybulbtemperature string, hourlypresentweathertype string, hourlypressurechange string, hourlypressuretendency string, hourlyrelativehumidity string, hourlysealevelpressure string, hourlyskyconditions string, hourlyvisibility string, hourlywinddirection string, hourlywindgustspeed string, hourlywindspeed string, rem string, reporttype string, sunrise string, sunset string)
row format delimited fields terminated by ',' lines terminated by '\n'
stored as textfile
tblproperties ("skip.header.line.count"="1");

load data local inpath "data.csv" overwrite into table temp;

DROP TABLE data;
CREATE TABLE data
(station string, time timestamp, hourlydrybulbtemperature int)
row format delimited fields terminated by ',' lines terminated by '\n'
stored as textfile;

INSERT INTO TABLE data
SELECT station, from_unixtime(unix_timestamp(time, "yyyy-MM-dd'T'HH:mm:ss")), hourlydrybulbtemperature
FROM temp;
DROP TABLE temp;
