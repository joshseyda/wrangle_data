# Data Wrangling for Democracy
---
#### I was tasked with taking two tables of slightly misformatted data, reformatting it, and then joining them to create a directory of imaginary voters with their associated voting precinct locations.
---
#### The way I chose to do this is by converting the csv.xlsx to a pure CSV file, then parse the CSV in Ruby automatically correcting mistakes along the way. After creating a new 'cleaned-up' CSV in Ruby I create and populate a SQL database with the two data sets. Once I have the tables created with the data in the proper places I will join the two tables together and have a single document of voters associated to their precinct voting locations.
