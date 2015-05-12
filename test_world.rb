require './world'
require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
 
describe World do

  let(:world) {World.new}

  describe '#initialize' do
    it "sets 10 floors and 3 elevators by default" do
      world.num_of_floors.must_equal 10
      world.elevators.size.must_equal 3
    end
  end

  describe '#CALL' do
    it "return 'You're already in the lowest level' if (user.floor == 1 && direction == 'DOWN')" do
      world.user.floor = 1
      world.CALL("DOWN").must_equal "You're already in the lowest level"
    end

    it "return 'You're already in the highest level' if (user.floor == num_of_floors && direction == 'UP')" do
      world.user.floor = world.num_of_floors
      world.CALL("UP").must_equal "You're already in the highest level"
    end

    it "call the closest elevator to travel to the user's floor and set the direction on the elevator" do
      closest_elevator = world.elevators.first
      closest_elevator.floor = 1
      world.CALL("UP")
      closest_elevator.door.must_equal true
      closest_elevator.direction.must_equal "UP"
    end

  end

  describe '#ENTER' do
    it "return 'You're already inside an elevator.'' if user is inside elevator" do
      world.user.inside_elevator = true
      world.ENTER(1).must_equal "You're already inside an elevator."
    end

    it "return 'The selected elevator is not available' if there is no elevators on that floor" do
      world.user.floor = 1
      world.elevators[0].floor = 3
      world.elevators[1].floor = 4
      world.elevators[2].floor = 5
      world.ENTER(world.elevators[0].id).must_equal "The selected elevator is not available"
      world.ENTER(world.elevators[1].id).must_equal "The selected elevator is not available"
      world.ENTER(world.elevators[2].id).must_equal "The selected elevator is not available"
    end

    it "'You're entering elevator no: 1.' when elevator 1 is available" do
      world.user.floor = 1
      chosen_elevator = world.elevators[0]
      chosen_elevator.floor = 1
      world.CALL("UP")
      world.ENTER(chosen_elevator.id).must_equal "You're entering elevator no: #{chosen_elevator.id}."
    end

  end

  describe '#EXIT' do
    it "returns 'You're not inside an elevator.'' unless user is inside elevator" do
      world.user.inside_elevator = false
      world.EXIT.must_equal "You're not inside an elevator."
    end

    it "returns 'You're exiting the elevator at floor 3.' when the user is exiting on 3rd floor" do
      world.user.floor = 1
      chosen_elevator = world.elevators[0]
      chosen_elevator.floor = 1
      world.CALL('UP')
      world.ENTER(chosen_elevator.id)
      world.GO(3)
      world.EXIT.must_equal "You're exiting the elevator at floor 3."
    end
  end

  describe '#go' do
    it "returns 'You're not inside an elevator.'' unless user is inside elevator" do
      world.user.inside_elevator = false
      world.GO(5).must_equal "You're not inside an elevator."
    end

    it "travels to 5th floor when calling GO with argument of 5" do
      world.user.floor = 1
      chosen_elevator = world.elevators[0]
      chosen_elevator.floor = 1
      world.CALL('UP')
      world.ENTER(chosen_elevator.id)
      world.GO(5)
      world.user.floor.must_equal 5
    end

    it "travels to 5th floor when calling GO with argument of 7,9,5" do
      world.user.floor = 1
      chosen_elevator = world.elevators[0]
      chosen_elevator.floor = 1
      world.CALL('UP')
      world.ENTER(chosen_elevator.id)
      world.GO(7,9,5)
      world.user.floor.must_equal 5
    end

  end

  describe '#CLOSE' do
    it "returns 'You're not inside an elevator.'' unless user is inside elevator" do
      world.user.inside_elevator = false
      world.CLOSE.must_equal "You're not inside an elevator."
    end

    it "returns 'You've arrived at the final destination.' if user is on the final destination" do
      world.user.floor = 1
      chosen_elevator = world.elevators[0]
      chosen_elevator.floor = 1
      world.CALL('UP')
      world.ENTER(chosen_elevator.id)
      world.GO(5)
      world.CLOSE.must_equal "You've arrived at the final destination."
    end

    it "continues travelling to the next available destination" do
      world.user.floor = 1
      chosen_elevator = world.elevators[0]
      chosen_elevator.floor = 1
      world.CALL('UP')
      world.ENTER(chosen_elevator.id)
      world.GO(5,7)
      world.CLOSE
      world.user.floor.must_equal 7
    end

  end

  describe '#where' do
    it "returns the floor location of the user" do
      world.user.floor = 1
      world.WHERE.must_equal "You're currently in floor 1."
      chosen_elevator = world.elevators[0]
      chosen_elevator.floor = 1
      world.CALL('UP')
      world.ENTER(chosen_elevator.id)
      world.GO(5,7)
      world.WHERE.must_equal "You're currently in floor 5."
      world.CLOSE
      world.EXIT
      world.WHERE.must_equal "You're currently in floor 7."
    end
  end

end