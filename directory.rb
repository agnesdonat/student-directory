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
    students << {name: name, cohort: info[:cohort], hobby: info[:hobby], country: info[:country], height: info[:height]}
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
  months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
  puts "Please enter the cohort"
  cohort = gets.chomp
  
  until months.include? cohort do
    puts "Enter valid month or leave empty again"
    cohort = gets.chomp
    cohort = months[1] if cohort.empty?
  end
      
  puts "Please enter a hobby"
  hobby = gets.chomp
  puts "Please enter their country of origin"
  country= gets.chomp
  puts "Please enter their height"
  height = gets.chomp.to_i
  return {cohort: cohort, hobby: hobby, country: country, height: height}
end  

def print_header
 puts "The students at Makers Academy
  -------------".lines.map {|line| line.strip.center(120) }
end

def print(students) 
  puts "Please enter a month to see students of that cohort" 
  user_input_month = gets.chomp
  
  students.map do |student|
   if user_input_month == student[:cohort]
     puts student[:name].center(120)
   else
     puts "We have no students enrolled on the #{user_input_month} cohort.".center(120)   
   end
  end
end

def print_footer(names) 
  
  puts "\n Overall, we have #{names.count} great students".lines.map {|line| line.strip.center(120)}
end  

students = input_students
print_header
print(students)
# print_footer(students)