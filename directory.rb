@students = [] # an empty array accessible to all methods

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit" # 9 because we'll be adding more items
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end 

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again."
  end  
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.strip
    # store information in variable "info" from more_info method
  if !name.empty? 
      info = more_info
  end
    # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    @students << {name: name, cohort: info[:cohort]} # hobby: info[:hobby], country: info[:country], height: info[:height]}
    if @students.length == 1
      puts "Now we have 1 student."
    else
      puts "Now we have #{@students.count} students."
    end  
    # get another name from the user
    name = STDIN.gets.strip
    if !name.empty? 
      info = more_info
    end  
  end
    # return the array of students
    # @students
end

def more_info
  months = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
  puts "Please enter the cohort"
  cohort = gets.strip
  
  until months.include? cohort do
    puts "Enter valid month or leave empty again"
    cohort = STDIN.gets.strip
    cohort = months[1] if cohort.empty?
  end
      
  puts "Please enter a hobby"
  hobby = STDIN.gets.chomp
  puts "Please enter their country of origin"
  country= STDIN.gets.chomp
  puts "Please enter their height"
  height = STDIN.gets.chomp.to_i
  return {cohort: cohort, hobby: hobby, country: country, height: height}
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
 puts "The students of my cohort at Makers Academy
  -------------".lines.map {|line| line.strip.center(120) }
end

def print_student_list
  i = 0
  while @students.length > i do
  puts "name: #{@students[i][:name]}, cohort: #{@students[i][:cohort]}".center(120) # hobby: #{@students[i][:hobby]}, country: #{@students[i][:country]}, height: #{@students[i][:height]} cm"
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

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else # if it does not exist
    puts "Sorry, #{filename} does not exist."
    exit # quit the program
  end
end

try_load_students
interactive_menu 
# @students = input_students
# print_header
# print(students)
# print_footer(students)