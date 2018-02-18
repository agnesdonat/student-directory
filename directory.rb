@students = [] # an empty array accessible to all methods
@cohort = :november
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

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, @cohort = line.chomp.split(',')
    adding_students(name)
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