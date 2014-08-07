students = [
	{:name => "Ruth Earle", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Andy Gates", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Marc Singh", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Faisal Aydarus", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Ethel Ng", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Kevin Daniells", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Maya Driver", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Leopold Kwok", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "James McNeil", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Jerome Pratt", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "David Wickes", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Javier Silverio", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Elliot Lewis", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Ben Tillett", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Vincent Koch", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Michelle Ballard", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Tatiana Soukiassian", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Mervé Silk", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Albert Vallervu", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Lovis Schultze", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Chris Oatley", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Spike Lindsey", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Nick Roberts", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""},
	{:name => "Henry Stanley", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""}
]

students = []

class Array
	def each
		i = 0
		while i < self.length
			yield self[i]
			i += 1
		end
		puts "Oook!"
	end
end

def print2(array)
	i = 0
	while i < array.length
		puts "#{student[:name]} (#{student[:cohort]} cohort)"
	end
end

def print_header
	puts "The students of my cohort at Makers Academy"
	puts "------------------------"
end

def print(students)
	students.each do |student|
		puts "#{student[:name]} (#{student[:cohort]} cohort)"
	end
end

def start_with(students, start_letter)
	students.select {|student| student[:name][0] == start_letter}
end

def print_with_index(students)
	students.each_with_index do |student, index|
		puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
	end
end

def print_student_count(students)
	puts "The current number of students in the directory is #{students.size}"
end

def print_footer(names)
	if names.length > 1
		puts "Overall, we have #{names.length} great students"
	else
		puts "Overall, we have #{names.length} great student"
	end
end

def valid_category(index,student)
	(index.to_i < student.length) && (index !~ /\D/)
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

def update_student_array(student, key)
	puts "You could have lots of #{key.to_s.capitalize}"
	puts "So enter them one by one and hit return twice when done"
	array = []
	unless student[key].empty?
		puts "Would you like to add to existing #{key.to_s.capitalize} or start over?"
		puts "y to start over, anything else to keep"
		start_over = gets.chomp
		start_over == y ? array = [] : array = student[key]
	end
	input = gets.chomp
	until input.empty?
		array << input
		puts "#{key.to_s.capitalize} currently contains #{pp_array(array)}"
		input = gets.chomp
	end
	puts "updating #{student[:name]}'s #{key} to #{pp_array(array)}"
	student[key] = array
end

def update_student(student, key)
	if student[key].class == Array
		student = update_student_array(student, key)
	else
		puts "change #{key.to_s.capitalize} to: "
		value = gets.chomp
		key == :cohort ? student[key] = value.downcase.to_sym : student[key] = value
		puts "updated #{key.to_s.capitalize} for #{student[:name]} to #{value}"
	end
	student
end

def student_in_directory?(directory, test_name)
	not directory.select {|student| student[:name] == test_name}.empty?
end

def get_index_by_name(directory, student_name)
	directory.find_index{|student| student[:name] == student_name}
end

def new_student(name)
	{:name => "#{name}", :cohort => :August, :hobbies => [], :height_cm => 0, :country_of_origin => ""}
end

def choose_category(student)
	while true
		puts "Please choose a category to update"
		student.each_with_index {|(key,value), index| puts "#{index}. #{key.to_s.capitalize} (currently set to : #{pretty_print(value)}"}
		index = gets.chomp
		if valid_category(index, student) then
			key = student.keys[index.to_i]
		else
			puts "Invalid index"
		end
		return key if key
	end
end

def input_students
	puts "Welcome to the new improved student adding CLI thing"
	puts "To start, please enter the name of a student."
	puts "To finish, just hit return twice"
	students = []
	name = gets.chomp
	until name.empty? do
		student_in_directory?(students, name) ? student = students.slice!(get_index_by_name(students, name)): student = new_student(name)
		key = choose_category(student)
		student = update_student(student, key)
		students << student
		print_student_count(students)
		puts "Which student to update now?"
		name = gets.chomp
	end
	students
end

students = input_students
print_header
print(students)
print_footer(students)