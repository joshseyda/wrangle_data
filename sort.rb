require 'csv'

src_dir = "/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/precinct_polling_list.csv"
dst_dir = "/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/precinct_polling_list_sort.csv"
puts " Reading data from  : #{src_dir}"
puts " Writing data to    : #{dst_dir}"

#create a new file 
csv_out = File.open(dst_dir, 'wb')

#read from existing file
CSV.foreach(src_dir , headers: true) do |row|
  puts row.inspect

  if row["Precinct"] == nil
    if /((...)\-(...))/.match(row["Country"])
      puts "reassigning 3 to 4"
      row["Precinct"] = row["Country"]
      puts row
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