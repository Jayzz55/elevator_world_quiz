require './elevator'
require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe Elevator do

  let(:elevator) {Elevator.new(10)}

  # describe '#self.find' do
  #   it "finds the elevator instance by the id" do
  #     elevator.must_equal Elevator.find(1)
  #   end

  # end

  # describe '#self.count' do
  #   it "counts the number of Elevator instances created" do
  #     Elevator.count.must_equal 1
  #   end

  # end

  describe '#open_door' do
    it "sets the door property to true" do
      elevator.open_door
      elevator.door.must_equal true
    end
  end

  describe '#close_door' do
    it "sets the door property to false" do
      elevator.open_door
      elevator.close_door
      elevator.door.must_equal false
    end

  end

  describe '#set_destination' do
    it "sets the destination from the input array" do
      elevator.set_destination([1,2,3])
      elevator.destination.must_equal [1,2,3]
    end
  end

  describe '#travel' do
    it "travels to 3rd floor when current floor is 2, destination input is [7,3,9], and direction is UP" do
      elevator.floor = 2
      elevator.direction = "UP"
      elevator.destination = [7,3,9]
      elevator.travel
      elevator.floor.must_equal 3
    end

    it "travels to 5th floor when current floor is 10, destination input is [1,5,3] and direction is UP" do
      elevator.floor = 10
      elevator.direction = "DOWN"
      elevator.destination = [1,5,3]
      elevator.travel
      elevator.floor.must_equal 5
    end
  end

  describe '#skip_to_last_destination' do
    it "the floor property is set to 9 when the destination is [2,4,6,9]" do
      elevator.destination = [2,4,6,9]
      elevator.skip_to_last_destination
      elevator.floor.must_equal 9
    end
  end

end