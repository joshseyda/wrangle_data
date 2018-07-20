require 'csv'

src_dir = "/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/precinct_polling_list.csv"
dst_dir = "/Users/joshuaseyda/Documents/wdi1/democracy_works/democracy_works_01/precinct_polling_list_sort.csv"
puts " Reading data from  : #{src_dir}"
puts " Writing data to    : #{dst_dir}"
#create a new file 
csv_out = File.open(dst_dir, 'wb')
#read from existing file

CSV.foreach(src_dir , :headers => true) do |row|
  
  new_row = row.split(',')
  if new_row[4] == " "
    if /((...)\-(...))/.match(new_row[3])
      new_row[4] = new_row[3]
    elsif /((...)\-(...))/.match(new_row[2])
      new_row[4] = new_row[3]
    else
      puts "I can not find the precinct ID in columns 2, 3, or 4!"
    end
    
  end
  street apt city  state zipcode precinct_id 
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
  newrow = new_row.join(',')
  #Lastly,  write back the edited , regexed data ..etc to an out file.
  csv_out << newrow

end

# close the file 
csv_out.close