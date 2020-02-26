DROP TABLE temp;
CREATE TABLE temp
(station string, time string, report string, source string, dailyweather string, hourlyaltimetersetting string, hourlydewpointtemperature string, hourlydrybulbtemperature string, HourlyPrecipitation string, hourlypresentweathertype string, hourlypressurechange string, hourlypressuretendency string, hourlyrelativehumidity string, hourlysealevelpressure string, hourlyskyconditions string, HourlyStationPressure string, hourlyvisibility string, hourlywetbulbtemperature string, hourlywinddirection string, hourlywindgustspeed string, hourlywindspeed string, rem string, reporttype string, sunrise string, sunset string)
row format delimited fields terminated by ',' lines terminated by '\n'
stored as textfile
tblproperties ("skip.header.line.count"="1");

load data local inpath "data.csv" overwrite into table temp;

DROP TABLE data;
CREATE TABLE data
(station string, time timestamp, hourlypresentweathertype string, hourlydrybulbtemperature int, hourlysealevelpressure decimal(5,3), hourlyrelativehumidity smallint, hourlywinddirection smallint, hourlywindspeed smallint)
row format delimited fields terminated by ',' lines terminated by '\n'
stored as textfile;

INSERT INTO TABLE data
SELECT station, from_unixtime(unix_timestamp(time, "yyyy-MM-dd'T'HH:mm:ss")), hourlypresentweathertype, hourlydrybulbtemperature, hourlysealevelpressure, hourlyrelativehumidity, hourlywinddirection, hourlywindspeed
FROM temp;
DROP TABLE temp;
