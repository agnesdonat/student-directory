@students = [] # an empty array accessible to all methods
@cohort = :november
def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit" 
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end 

def process(selection)
  case selection
    when "1" then input_students 
    when "2" then show_students
    when "3" then save_students 
      puts "Student's name has been saved to the database."
    when "4" then  load_students 
      puts "Student database have been loaded."
    when "9" then puts "Bye!"
      exit
    else puts "I don't know what you meant, try again."
  end  
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
    # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    adding_students(name) 
    if @students.length == 1 
      puts "Now we have 1 student."
    else 
      puts "Now we have #{@students.count} students."
    end  
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def adding_students(name)
  @students << {name: name, cohort: :november}
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
  @students.each do |student|
  puts "name: #{student[:name]}, #{student[:cohort]} cohort".center(120) 
  end
end

def print_footer
  students_length = @students.length
  case students_length
  when 0 then puts "\n We have no students enrolled at the moment.".lines.map {|line| line.strip.center(120)}
  when 1 then puts "\n Overall, we have 1 great student.".lines.map {|line| line.strip.center(120)}
  else puts "\n Overall, we have #{@students.count} great students.".lines.map {|line| line.strip.center(120)}
  end
end

def save_students
  puts "Where do you want to save the new studnet's name?"
  file_to_save = gets.chomp
  # open the file for writing
  File.open(file_to_save, "w") do |f|
  # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      f.puts csv_line
    end  
  end
  # file.close
end

def load_students
  puts "Which file do you want to load?"
  file_to_load = gets.chomp
  File.open(file_to_load, "r") do |f|
    f.readlines.each do |line|
      name, @cohort = line.chomp.split(',')
      adding_students(name)
    end
  end  
  # file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(file_to_load)
      puts "Loaded #{@students.count} from #{filename}"
  else # if it does not exist
    puts "Sorry, #{filename} does not exist."
    exit # quit the program
  end
end

try_load_students
interactive_menu 