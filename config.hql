DROP TABLE data;
CREATE TABLE data
(station string, time string, report string, source string, dailyweather string, hourlyaltimetersetting string, hourlydewpointtemperature string, hourlydrybulbtemperature string, hourlypresentweathertype string, hourlypressurechange string, hourlypressuretendency string, hourlyrelativehumidity string, hourlysealevelpressure string, hourlyskyconditions string, hourlyvisibility string, hourlywinddirection string, hourlywindgustspeed string, hourlywindspeed string, rem string, reporttype string, sunrise string, sunset int)
row format delimited fields terminated by ',' lines terminated by '\n'
stored as textfile
tblproperties ("skip.header.line.count"="1");

load data local inpath "data.csv" overwrite into table data;
