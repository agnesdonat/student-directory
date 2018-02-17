@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
    # create an empty array
    # students = []
    # get the first name
  name = gets.strip
    # store information in variable "info" from more_info method
  if !name.empty? 
      info = more_info
  end
    # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    @students << {name: name, cohort: info[:cohort], hobby: info[:hobby], country: info[:country], height: info[:height]}
    if @students.length == 1
      puts "Now we have 1 student."
    else
      puts "Now we have #{@students.count} students."
    end  
    # get another name from the user
    name = gets.strip
    if !name.empty? 
      info = more_info
    end  
  end
    # return the array of students
    @students
end

def more_info
  months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
  puts "Please enter the cohort"
  cohort = gets.strip
  
  until months.include? cohort do
    puts "Enter valid month or leave empty again"
    cohort = gets.strip
    cohort = months[1] if cohort.empty?
  end
      
  puts "Please enter a hobby"
  hobby = gets.chop
  puts "Please enter their country of origin"
  country= gets.chop
  puts "Please enter their height"
  height = gets.chop.to_i
  return {cohort: cohort, hobby: hobby, country: country, height: height}
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end  

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again."
  end  
end

def print_header
 puts "The students of my cohort at Makers Academy
  -------------".lines.map {|line| line.strip.center(120) }
end

def print_student_list
  i = 0
  while @students.length > i do
  puts "name: #{@students[i][:name]}, cohort: #{@students[i][:cohort]}, hobby: #{@students[i][:hobby]}, country: #{@students[i][:country]}, height: #{@students[i][:height]} cm".center(120)
  i += 1
  end
end

def print_footer
  if @students.length == 0
    puts "\n We have no students enrolled at the moment.".lines.map {|line| line.strip.center(120)}
  elsif @students.length == 1
    puts "\n Overall, we have 1 great student.".lines.map {|line| line.strip.center(120)}
  else
    puts "\n Overall, we have #{@students.count} great students.".lines.map {|line| line.strip.center(120)}
  end
end  

interactive_menu 
# @students = input_students
# print_header
# print(students)
# print_footer(students)