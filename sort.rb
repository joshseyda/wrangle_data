require 'csv'

src_dir = "/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/precinct_polling_list.csv"
dst_dir = "/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/precinct_polling_list_sort.csv"
puts " Reading data from  : #{src_dir}"
puts " Writing data to    : #{dst_dir}"
#create a new file 
csv_out = File.open(dst_dir, 'wb')
#read from existing file

CSV.foreach(src_dir , :headers => true) do |row|
  puts row[4]
  # new_row = row.split(',')
  if row[4] == nil
    if /((...)\-(...))/.match(row[3])
      puts "reassigning 3 to 4"
      row[4] = row[3];
      puts row
      csv_out << row
    elsif /((...)\-(...))/.match(row[2])
      puts "reassigning 2 to 4"
      row[4] = row[3];
      puts row
      csv_out << row
    else
      puts "I can not find the precinct ID in columns 2, 3, or 4!"
    end
  else
    csv_out << row 
  end
  # street apt city  state zipcode precinct_id 
  #then you can do this 
  # newrow = row.each_with_index { |rowcontent , row_num| puts "#     {rowcontent} #{row_num}" }

  # OR array to hash .. just saying .. maybe hash of arrays.. 
  #h = Hash[*row]
  #csv_out << h

  # OR use map  
  #newrow = row.map(&:capitalize)
  #csv_out << h

  #OR use each  ... Add and end 
  #newrow.each do |k,v| puts "#{k} is #{v}"
  # newrow = row.join(',')
  #Lastly,  write back the edited , regexed data ..etc to an out file.

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