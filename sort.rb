require 'csv'

src_dir = "/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/precinct_polling_list.csv"
dst_dir = "/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/precinct_polling_list_sort.csv"
puts " Reading data from  : #{src_dir}"
puts " Writing data to    : #{dst_dir}"

# quick reference for re-assigning precint ids to be uniform
state_codes = {
  "ARI": "004",
  "CAL": "006",
  "CON": "009",
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
csv_out << "Street,City,State/ZIP,Country,Precinct
"
#read from existing file
CSV.foreach(src_dir , headers: true) do |row|
  puts row.inspect
  # the below conditional checks the values in the CSV rows for the format XXX-XXX and allocates the proper values accordingly
  if row["State/ZIP"] == "USA"
   zip_code = /(\d{5})/.match(row["City"])
   state_code = /([A-Z][A-Z])/.match(row["City"]) || /([A-Z][A-Z])/.match(row["Street"])
   new_zip = "#{state_code} #{zip_code}"
   row["State/ZIP"] =
  end
  if row["Precinct"] == nil
    # searching for where the precinct value is
    if /((...)\-(...))/.match(row["Country"])
      puts "reassigning col 3 to col 4"
      string_val = row["Country"].to_s
      split_string = string_val.split("-")
      new_val = state_codes[split_string[0].to_sym]
      row["Precinct"] = "#{new_val}-#{split_string[1]}"
      # reassigning Country value after making sure the column's value isn't the precinct
      row["Country"] = "USA"
      # fixing a column's misplaced State/ZIP
      if /((\D{2})\s(\d{5}))/.match(row["Street"])
        row["State/ZIP"] = /((\D{2})\s(\d{5}))/.match(row["Street"]).to_s
      end
      puts row.inspect
      csv_out << row

    elsif /((...)\-(...))/.match(row["State/ZIP"])
      puts "reassigning col 2 to col 4"
      string_val = row["State/ZIP"].to_s
      split_string = string_val.split("-")
      new_val = state_codes[split_string[0].to_sym]
      row["Precinct"] = "#{new_val}-#{split_string[1]}"
      row["Country"] = "USA"
      if /((\D{2})\s(\d{5}))/.match(row["Street"])
        row["State/ZIP"] = /((\D{2})\s(\d{5}))/.match(row["Street"]).to_s
        puts row["State/ZIP"]
      end
      puts row.inspect
      csv_out << row

    else
      puts "I can not find the precinct ID in columns 2, 3, or 4!"
    end

  else
    # this command pushes the row to a new document which our database will be built off of

    if /(--)/.match(row["Precinct"])
      sub_str_val = row["Precinct"].to_s
      split_sub= sub_str_val.split("--")
      new_sub_str = "#{split_sub[0]}-0#{split_sub[1]}"
      row["Precinct"] = new_sub_str
    end  

    if /((\D{2})\s(\d{5}))/.match(row["Street"])
      row["State/ZIP"] = /((\D{2})\s(\d{5}))/.match(row["Street"]).to_s
      puts row["State/ZIP"]
    end

    row["Country"] = "USA"
    string_val = row["Precinct"].to_s
    split_string = string_val.split("-")
    new_val = state_codes[split_string[0].to_sym]
    row["Precinct"] = "#{new_val}-#{split_string[1]}"
    puts row.inspect
    csv_out << row

  end

end

# close the file 
csv_out.close