require './world'
require 'pry'

puts "Elevator World Setup"
puts "=============================="
puts "set number of floors and elevators (num_of_floors, num_of_elevators). Ex: 10,3 (10 floors and 3 elevators)"
input = gets.chomp.split(',')
num_of_floors = input.first.to_i
num_of_elevators = input.last.to_i

# In-game menu
while true
puts "==============================="
puts "Welcome to Elevator World"
puts "==============================="
puts "1. SEED"
puts "2. CALL an elevator with a direction ('CALL UP' or 'CALL DOWN')"
puts "3. ENTER elevator"
puts "4. EXIT elevator"
puts "5. CLOSE elevator door"
puts "6. GO to destination floors."
puts "7. WHERE prints the floor the user is on (starts at 1)"
puts "8. QUIT"
puts "-----------------------------------------------------"
print "Type your command: "
user_option = gets.chomp.upcase
case user_option
  when "SEED" 
    world = World.new(num_of_floors = 10,num_of_elevators = 3)
  when "CALL UP" 
    puts world.CALL('UP')

  when "CALL DOWN" 
    puts world.CALL('DOWN')

  when "ENTER"
    puts "ENTER N where N is the index of the elevator"
    elevator_index = gets.chomp.to_i

    puts world.ENTER(elevator_index)
    
  when "EXIT"
    puts world.EXIT

  when "CLOSE"
    puts world.CLOSE

  when "GO" 
    puts "Enter floor destination (can be MULTIPLE, EX: GO 4,5,6)"
    arguments_array = []
    arguments = arguments_array.push(gets.chomp.split(',')).flatten!
    floors_array = arguments_array.map{|item| item.to_i}
    puts world.GO(*floors_array)
    
  when "WHERE" 
    puts world.WHERE

  when "QUIT" 
    #exit
    break
  else
    puts "please Type the command as indicated."
  end
end
