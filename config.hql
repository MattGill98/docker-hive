DROP TABLE data;
CREATE TABLE data
(station string, time string, report string, source string, dailyweather string, hourlyaltimetersetting string, hourlydewpointtemperature int, hourlydrybulbtemperature int, hourlypresentweathertype string, hourlypressurechange string, hourlypressuretendency string, hourlyrelativehumidity int, hourlysealevelpressure string, hourlyskyconditions string, hourlyvisibility string, hourlywinddirection int, hourlywindgustspeed int, hourlywindspeed int, rem string, reporttype string, sunrise int, sunset int)
row format delimited fields terminated by ',' lines terminated by '\n'
stored as textfile
tblproperties ("skip.header.line.count"="1");

load data local inpath "data.csv" overwrite into table data;
