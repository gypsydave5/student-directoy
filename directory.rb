@students = []

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end

def print_students
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.length} great students"
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.chomp
  while !name.empty? do
    @students << {:name => name, :cohort => :november}
    puts "Now we have #{@students.length} students"
    name = gets.chomp
		p @students
  end
end

def print_menu
	menu = [
		"1. Input the students",
		"2. Show the students",
		"3. Save students",
		"9. Exit"
	]
	menu.each {|menu_item| puts menu_item}
end

def show_students
	print_header
	print_students
	print_footer
end

def process(input)
	case input
	when "1"
		input_students
	when "2"
		show_students
	when "3"
		save_students
	when "9"
		exit
	else
		puts "What are you doing, Dave?"
	end
end

def save_students
	file = File.open("students.csv", "w")
		@students.each do |student|
			student_data = [student[:name], student[:cohort]]
			data_line = student_data.join(' ')
			file.puts data_line
		end
		file.close
end

def interactive_menu
	loop do
		print_menu
		process(gets.chomp)
	end
end

interactive_menu