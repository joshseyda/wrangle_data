CREATE DATABASE democracy_works
DROP TABLE IF EXISTS precinct CASCADE;
DROP TABLE IF EXISTS citizens CASCADE;

CREATE TABLE precinct (
    id integer NOT NULL,
    street text NOT NULL,
    city text NOT NULL,
    state_zip text NOT NULL,
    precinct_id text NOT NULL
);

CREATE TABLE citizens (
    id integer NOT NULL,
    street text NOT NULL,
    apt text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    zipcode text NOT NULL,
    precinct_id text NOT NULL
);

COPY precinct FROM 'precinct_polling_list.csv' WITH (FORMAT csv);

COPY citizens FROM 'addresses.csv' WITH (FORMAT csv);