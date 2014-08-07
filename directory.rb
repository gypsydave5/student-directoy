@students = []
@student = {}

def get_input
	STDIN.gets.chomp
end

def print_header
	puts "The students of my cohort at Makers Academy"
	puts "-------------"
end

def print_students
	@students.each do |student|
		puts "#{student[:name]} (#{student[:cohort]} cohort)"
	end
end

def new_student(name)
	{:name => "name", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""}
end

def print_footer
	puts "Overall, we have #{@students.length} great students"
end

def start_with(students, start_letter)
	students.select {|student| student[:name][0] == start_letter}
end

def input_students
	puts "Please enter the required student information"
	print "Value for student name: "
	name = get_input
	if student_exists?(name)
		puts "\"#{name}\" already exists. Diverting to update..."
		edit_student(name)
	else
		@student = new_student(name)
		@student.keys.to_a.each.drop(1) do |key|
			case @student[key].class
			when Array
				@student[key] = update_array_value(key)
			when Symbol
				print "Value for #{pretty_print(key)}: "
				value = get_input
				@student[key] = value.downcase.to_sym
			when String
				print "Value for #{pretty_print(key)}: "
				value = get_input
				@student[key] = value
			end
		end
	end
end

def print_menu
	menu = [
		"1. Input the students",
		"2. Show the students",
		"3. Save students",
		"4. Load students",
		"9. Exit"
	]
	menu.each {|menu_item| puts menu_item}
end

def show_students
	print_header
	print_students
	print_footer
end

def put_keys_by_index
	@student.each_with_index {|(key,value), index| puts "#{index}. #{pretty_print(key)} currently set to \"#{pretty_print(value)}\""}
end

def student_exists?(name)
	@students.empty? ? false : @students.values.include?(name.downcase.capitalize)
end

def pop_student_by_name(name)
	index = @students.find_index{|student| student[:name] == name}
	@students.slice!(index)
end

def edit_student(name)
	@student = pop_student_by_name(name)
	key = choose_update_key
	update_student_value(key)
end

def edit_students
	puts "Enter the name of the student you'd like to edit"
	input = get_input
	if student_exists?(name)
		edit_student(name)
	else
		puts "Record for student \"#{input}\" does not exist"
	end
	@students << @student
end


def update_student_array (key)
	puts "You could have lots of #{key.to_s.capitalize}"
	puts "So enter them one by one and hit return twice when done"
	array = []
	unless @student[key].empty?
		puts "Would you like to add to existing #{key.to_s.capitalize} or start over?"
		puts "y to start over, anything else to keep"
		start_over = get_input
		start_over == y ? array = [] : array = student[key]
	end
	input = get_input
	until input.empty?
		array << input
		puts "#{key.to_s.capitalize} currently contains #{pp_array(array)}"
		input = gets.chomp
	end
	puts "updating #{@student[:name]}'s #{key} to #{pp_array(array)}"
	@student[key] = array
end

def update_student_value(key)
	if @student[key].class == Array
		@student = update_student_array(student, key)
	else
		puts "change #{key.to_s.capitalize} to: "
		value = gets.chomp
		@student[key].class == Symbol ? student[key] = value.downcase.to_sym : student[key] = value
		puts "updated #{key.to_s.capitalize} for #{student[:name]} to #{value}"
	end
end

def choose_update_key
	while true
		puts "Please choose a value to update"
		@student.each_with_index {|(key,value), index| puts "#{index + 1}. #{key.to_s.capitalize} (currently set to : #{pretty_print(value)})"}
		index = get_input
		if valid_category(index) then
			key = student.keys[index.to_i]
		else
			puts "Invalid index"
		end
		return key if key
	end
end

def valid_key(index)
	((index.to_i - 1) < @student.length) && (index !~ /\D/)
end

def process(input)
	case input
	when "1"
		input_students
	when "2"
		show_students
	when "3"
		save_students
	when"4"
		load_students()
	when "5"
		edit_students()
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

def pretty_print(input)
	if input.class == Array
		return pp_array(input)
	elsif input.to_s.empty?
		"none"
	elsif input.class != String
		input.to_s.capitalize
	else
		input.to_s
	end
end

def pp_array(array)
	if array.size > 2
		"#{array[0..-2].join(', ')} and #{array[-1]}"
	elsif array.size > 1
		"#{array.join(' and ')}"
	elsif array.size == 1
		"#{array[0]}"
	else
		"none"
	end
end

def load_students_filename
	print "Filename? "
	filename = get_input
	filename == "" ? load_students : false
end

def load_students(filename="students.csv")
	file = File.open(filename, "r")
	file.readlines.each do |line|
		name, cohort = line.chomp.split(',')
		@students << {name: name, cohort: cohort.downcase.to_sym}
	end
	file.close
end

def try_load_students
	filename = ARGV.first
	return if filename.nil?
	if File.exists?(filename)
		load_students(filename)
		puts "Loaded #{students.length} from #{filename}"
	else
		puts "Sorry,#{filename} doesn't exist."
		exit
	end
end

def interactive_menu
	loop do
		print_menu
		process(STDIN.gets.chomp)
	end
end

try_load_students unless ARGV.empty?
interactive_menu