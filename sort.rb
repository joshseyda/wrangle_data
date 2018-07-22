require 'csv'

src_dir = "/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/precinct_polling_list.csv"
dst_dir = "/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/precinct_polling_list_sort.csv"
puts " Reading data from  : #{src_dir}"
puts " Writing data to    : #{dst_dir}"

state_codes = {
  "CAL": "006",
  "CT": "009",
  "FLO": "012",
  "GEO": "013",
  "ILL": "017",
  "MAS": "025",
  "MAI": "023",
  "MIN": "027",
  "NEWJ": "034",
  "NEWY": "036",
  "PEN": "042",
  "VIR": "051",
  "WIS": "055"
}

#create a new file 
csv_out = File.open(dst_dir, 'wb')

#read from existing file
CSV.foreach(src_dir , headers: true) do |row|
  puts row.inspect
  # the below conditional checks the values in the CSV rows for the format XXX-XXX and allocates the proper values accordingly
  if row["Precinct"] == nil
    if /((...)\-(...))/.match(row["Country"])
      puts "reassigning 3 to 4"
      row["Precinct"] = row["Country"]
      puts row
      # /(...)\-/.match(row["Precinct"])
      string_val = row["Precinct"].to_s
      split_string = string_val.split("-")
      puts split_string
      new_val = state_codes[split_string[0].to_sym]
      p new_val

      csv_out << row
    elsif /((...)\-(...))/.match(row["State/ZIP"])
      puts "reassigning 2 to 4"
      row["Precinct"] = row["State/ZIP"] 
      puts row
      csv_out << row
    else
      puts "I can not find the precinct ID in columns 2, 3, or 4!"
    end
  else
    # this command pushes the row to a new document which our database will be built off of
    csv_out << row
  end
 puts "*"
 puts "*"
 puts "*"
 puts "*"
 puts "*"
 puts "*"
 puts "*"
 puts "*"
end

# close the file 
csv_out.close