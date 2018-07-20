CREATE DATABASE democracy_works;
\connect democracy_works

DROP TABLE IF EXISTS precincts CASCADE;
DROP TABLE IF EXISTS citizens CASCADE;

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