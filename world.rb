require './elevator'
require './user'

class World
  attr_accessor :user, :elevators, :num_of_floors, :num_of_elevators, :selected_elevator

  def initialize(num_of_floors = 10, num_of_elevators = 3)
    @user = User.new
    @num_of_floors = num_of_floors
    @elevators = []
    (1..num_of_elevators).each{|index| @elevators << Elevator.new(rand(num_of_floors) + 1)}
  end

  def CALL(direction)
    return "You're already in the lowest level" if (@user.floor == 1 && direction == 'DOWN')
    return "You're already in the highest level" if (@user.floor == @num_of_floors && direction == 'UP')
    call_elevator(find_closest_elevator, direction)
  end

  def ENTER(elevator_index)
    return "You're already inside an elevator." if @user.inside_elevator
    @selected_elevator = Elevator.find (elevator_index)
    return "The selected elevator is not available" if @user.floor != @selected_elevator.floor
    @user.inside_elevator = true
    @selected_elevator.close_door
    "You're entering elevator no: #{elevator_index}."
  end

  def EXIT
    return "You're not inside an elevator." unless @user.inside_elevator
    @selected_elevator.close_door
    @user.inside_elevator = false
    @user.floor = @selected_elevator.floor
    @selected_elevator.skip_to_last_destination if @selected_elevator.destination.size > 0
    "You're exiting the elevator at floor #{@user.floor}."
  end

  def GO(*floors_array)
    return "You're not inside an elevator." unless @user.inside_elevator
    @selected_elevator.set_destination (floors_array)
    travel
  end

  def CLOSE
    return "You're not inside an elevator." unless @user.inside_elevator
    @selected_elevator.close_door
    if @selected_elevator.destination.size > 0
      travel
    else
      "You've arrived at the final destination."
    end
  end

  def WHERE
    "You're currently in floor #{@user.floor}."
  end

  private

  def find_closest_elevator
    elevator_hash = @elevators.inject({}) do |result, element|
      result[element.id] = (element.floor - @user.floor).abs
      result
    end

    closest_elevator = elevator_hash.select{|key, value| value == elevator_hash.values.min}

    Elevator.find(closest_elevator.keys.first)
  end

  def call_elevator(elevator,direction)
    elevator.direction = direction
    elevator.set_destination([@user.floor])
    elevator.travel
    puts "Elevator no. #{elevator.id} has arrived at floor #{@user.floor}"
    elevator.open_door
    puts "Elevator no. #{elevator.id}'s door is opened"
  end

  def travel
    @selected_elevator.travel
    @user.floor = @selected_elevator.floor
    "The lift has arrived at floor #{@user.floor} \n you can either 'EXIT' or CLOSE"
  end

end
