CREATE DATABASE democracy_works;
\connect democracy_works

DROP TABLE IF EXISTS precincts CASCADE;
DROP TABLE IF EXISTS citizens CASCADE;
DROP TABLE IF EXISTS new_records CASCADE;

CREATE TABLE precincts (
    id serial NOT NULL,
    street text NOT NULL,
    city text NOT NULL,
    state_zip text NOT NULL,
    country text,
    precinct_id text 
);

CREATE TABLE citizens (
    id serial NOT NULL,
    street text NOT NULL,
    apt text ,
    city text NOT NULL,
    state text NOT NULL,
    zipcode text NOT NULL,
    precinct_id text NOT NULL
);

COPY precincts(street, city, state_zip, country, precinct_id) FROM '/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/precinct_polling_list_sort.csv' DELIMITER ',' CSV HEADER; 
COPY citizens(street, apt, city, state, zipcode, precinct_id) FROM '/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/addresses.csv' DELIMITER ',' CSV HEADER;  

CREATE TABLE new_records AS
SELECT precincts.precinct_id AS "ID", precincts.street AS "Voting_Street", precincts.city AS "Voting_City", precincts.state_zip AS "Precinct_ZIP", citizens.street AS "Citizen_Street", citizens.apt AS "Citizen_APT", citizens.city AS "Citizen_City", citizens.state AS "Citizen_State", citizens.zipcode  AS "Citizen_ZIP" FROM precincts
INNER JOIN citizens ON precincts.precinct_id = citizens.precinct_id;
