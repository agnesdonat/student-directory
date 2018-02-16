def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
    # create an empty array
  students = []
    # get the first name
  name = gets.chomp
    # store information in variable "info" from more_info method
  if !name.empty? 
      info = more_info
  end
    # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november, hobby: info[:hobby], country: info[:country], height: info[:height]}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
    if !name.empty? 
      info = more_info
    end  
  end
    # return the array of students
    students
end

def more_info
  puts "Please enter a hobby"
  hobby = gets.chomp
  puts "Please enter their country of origin"
  country= gets.chomp
  puts "Please enter their height"
  height = gets.chomp.to_i
  return {hobby: hobby, country: country, height: height}
end  

def print_header
 puts "The students of my cohort at Makers Academy
  -------------".lines.map {|line| line.strip.center(120) }
end

def print(students) 
  i = 0    
  while students.length > i do
    puts "name: #{students[i][:name]}, cohort: #{students[i][:cohort]}, hobby: #{students[i][:hobby]}, country of origin: #{students[i][:country]}, height: #{students[i][:height]} cm".center(120)
    i += 1
  end
end

def print_footer(names) 
  puts "\n Overall, we have #{names.count} great students".lines.map {|line| line.strip.center(120)}
end  

students = input_students
print_header
print(students)
print_footer(students)