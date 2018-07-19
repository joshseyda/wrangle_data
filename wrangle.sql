CREATE TABLE precinct 
(ZIP char(5), LATITUDE double precision, LONGITUDE double precision, 
CITY varchar, STATE char(2), COUNTY varchar, ZIP_CLASS varchar);

street city state/zip precinct_id
COPY zip_codes FROM '/path/to/csv/ZIP_CODES.txt' WITH (FORMAT csv);

CREATE TABLE citizens
(ZIP char(5), LATITUDE double precision, LONGITUDE double precision, 
CITY varchar, STATE char(2), COUNTY varchar, ZIP_CLASS varchar);

street apt city state zip precinct_id 
COPY zip_codes FROM '/path/to/csv/ZIP_CODES.txt' WITH (FORMAT csv);