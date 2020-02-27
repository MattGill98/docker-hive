DROP TABLE IF EXISTS temp_cities;
CREATE TABLE temp_cities
(city string, city_ascii string, lat string, lng string, country string, iso2 string, iso3 string, admin_name string, capital string, population string, id string)
row format delimited fields terminated by ',' lines terminated by '\n'
stored as textfile
tblproperties ("skip.header.line.count"="1");

load data local inpath "worldcities.csv" overwrite into table temp_cities;

DROP TABLE cities;
CREATE TABLE cities
(city string, lat decimal(9,6), lng decimal(9,6), country string)
row format delimited fields terminated by ',' lines terminated by '\n'
stored as textfile;

INSERT INTO TABLE cities
SELECT city_ascii, lat, lng, country
FROM temp_cities;
DROP TABLE temp_cities;



DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data
(station string, time string, report string, source string, dailyweather string, hourlyaltimetersetting string, hourlydewpointtemperature string, hourlydrybulbtemperature string, HourlyPrecipitation string, hourlypresentweathertype string, hourlypressurechange string, hourlypressuretendency string, hourlyrelativehumidity string, hourlysealevelpressure string, hourlyskyconditions string, HourlyStationPressure string, hourlyvisibility string, hourlywetbulbtemperature string, hourlywinddirection string, hourlywindgustspeed string, hourlywindspeed string, rem string, reporttype string, sunrise string, sunset string)
row format delimited fields terminated by ',' lines terminated by '\n'
stored as textfile
tblproperties ("skip.header.line.count"="1");

load data local inpath "climatedata.csv" overwrite into table temp_data;

DROP TABLE IF EXISTS data;
CREATE TABLE data
(station string, time timestamp, hourlypresentweathertype string, hourlydrybulbtemperature int, hourlysealevelpressure decimal(5,3), hourlyrelativehumidity smallint, hourlywinddirection smallint, hourlywindspeed smallint)
row format delimited fields terminated by ',' lines terminated by '\n'
stored as textfile;

INSERT INTO TABLE data
SELECT substr(station, length(station) - 4), from_unixtime(unix_timestamp(time, "yyyy-MM-dd'T'HH:mm:ss")), hourlypresentweathertype, hourlydrybulbtemperature, hourlysealevelpressure, hourlyrelativehumidity, hourlywinddirection, hourlywindspeed
FROM temp_data WHERE report != "SOD  ";
DROP TABLE temp_data;

CREATE TABLE temp_stations
(WBAN string, WMO string, callsign string, climatedivisioncode tinyint, ClimateDivisionStateCode tinyint, ClimateDivisionStationCode tinyint, name String, state String, location string, latitude decimal(9,6), longitude decimal(9,6), groundheight decimal(9,6), stationheight int, barometer int, timezone string)
row format delimited fields terminated by '|' lines terminated by '\n'
stored as textfile
tblproperties ("skip.header.line.count"="1");

load data local inpath "stations.txt" overwrite into table temp_stations;


DROP TABLE IF EXISTS stations;
CREATE TABLE stations
(WBAN string, name String, state String, location string, latitude decimal(9,6), longitude decimal(9,6), groundheight decimal(5,1))
row format delimited fields terminated by '|' lines terminated by '\n'
stored as textfile;

INSERT INTO TABLE stations
SELECT WBAN, name, state, location, latitude, longitude, groundheight
FROM temp_stations;

DROP table temp_stations;
