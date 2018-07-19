CREATE TABLE zip_codes 
(ZIP char(5), LATITUDE double precision, LONGITUDE double precision, 
CITY varchar, STATE char(2), COUNTY varchar, ZIP_CLASS varchar);

COPY zip_codes FROM '/path/to/csv/ZIP_CODES.txt' WITH (FORMAT csv);