# Data Wrangling for Democracy
---
#### I was tasked with taking two tables of slightly misformatted data, reformatting it, and then joining them to create a directory of imaginary voters with their associated voting precinct locations.
---
#### The way I chose to do this is by converting the csv.xlsx to a pure CSV file using the in application export function. Next I need to parse the CSV in Ruby, automatically correcting mistakes along the way. After creating a new 'cleaned-up' CSV  I create and populate a SQL database with the two CSV datasets. Once I have the tables created with the data formatted in the proper places I join the two tables together with an inner join and pass that into a new table, finally having a single document of voters associated to their precinct voting locations.
---
#### Here is the basic Regular Expression evaluation inside of a loop. The goal of this is to find Locations without precinct ids in the right place and find where they are, and reassign them to the correct place. <code>state_codes</code> is a hash with key value pairs of the first three letters of a state and its associated code. 
```Ruby
if row["Precinct"] == nil
    if /((...)\-(...))/.match(row["Country"])
      puts "reassigning col 3 to col 4"
      string_val = row["Country"].to_s
      split_string = string_val.split("-")
      new_val = state_codes[split_string[0].to_sym]
      row["Precinct"] = "#{new_val}-#{split_string[1]}"
      # fixing a column's misplaced State/ZIP
      if /((\D{2})\s(\d{5}))/.match(row["Street"])
        row["State/ZIP"] = /((\D{2})\s(\d{5}))/.match(row["Street"]).to_s
      end
      puts row.inspect
      csv_out << row
```
#### Essentially once the data was reformatted the joining of the documents was fairly straightforward. I give each column a more specific title for the new table, and join on the shared <code>precinct_id</code> value.
``` SQL
CREATE TABLE new_records AS
SELECT precincts.street AS "Voting_Street", precincts.city AS "Voting_City", precincts.state_zip AS "Precinct_ZIP", precincts.precinct_id, citizens.street AS "Citizen_Street", citizens.apt AS "Citizen_APT", citizens.city AS "Citizen_City", citizens.state AS "Citizen_State", citizens.zipcode  AS "Citizen_ZIP" FROM precincts
INNER JOIN citizens ON precincts.precinct_id = citizens.precinct_id;
```

---
#### [State Code Reference](https://www.census.gov/geo/reference/ansi_statetables.html)
