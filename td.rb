class Todo
	def clear_screen
		system "cls"
	end

	def open_app
		clear_screen
		view_all
	end

	def view_all
		clear_screen

		list_read = read_list

		list_read.each do |line|
			puts line if !line.include?("COMPLETE")
		end

		choose_action
	end

	def read_list
		list = File.open("mylist.txt","r").readlines
	end

	def choose_action
		puts %/
		What would you like to do with your list?
		1. Add todo
		2. Mark done
		3. View all
		4. Exit/

		choice = gets.chomp.downcase

		case choice
			when "1" then input_todo
			when "1." then input_todo
			when "add" then input_todo
			when "add todo" then input_todo
		
			when "2" then mark_done
			when "2." then mark_done
			when "mark" then mark_done
			when "mark done" then mark_done
			
			when "3" then view_all
			when "3." then view_all
			when "view" then view_all
			when "view all" then view_all

			when "4" then return
			when "4." then return
			when "exit" then return

			else
				p "Not a valid choice"
				choose_action
		end
	end

#ask for todo
	def input_todo
		p "Enter your new todo:"
		todo = gets.chomp
		add_todo(todo)
		view_all
	end

#write method
	def add_todo(todo)
		File.open("mylist.txt", "a") { |f| f.write "\n#{todo}" }
	end

#mark done method
	def mark_done
		clear_screen

		list_read = File.open("mylist.txt","a+").readlines

		list_read.each_with_index do |line, index|
			puts "#{index}. " + line if !line.include?("COMPLETE")
		end

		puts "Which todo do you want to mark complete? (Type the number)."
		
		choice = gets.chomp.to_i

		list_read.each_with_index do |line, index|
			if index == choice
				list_read[index] = line.chop + " COMPLETE\n"
			end
		end

		File.open("mylist.txt", "w") do |f|
			list_read.each_with_index do |line, index|
				if index == 0 
					f.write "#{line}"
				else
					f.write "#{line}"
				end
			end
		end

		view_all
	end

end

my_todo_list = Todo.new

my_todo_list.open_app