class Elevator
  attr_accessor :floor, :direction, :door, :id, :destination
  @@data = []

  def self.find(index)
    @@data.find {|item| item.id == index}
  end

  def self.count
    @@data.count
  end

  def initialize(floor) 
    @floor = floor
    @door = false
    @destination = []
    @@data << self
    @id = @@data.size
  end

  def open_door
    @door = true
  end

  def close_door
    @door = false
  end

  def set_destination (floors_array)
    @destination = floors_array
  end

  def travel
    @destination.sort! if @direction == "UP"
    @destination.sort!.reverse! if @direction == "DOWN"
    @floor = @destination.shift
  end

  def skip_to_last_destination
    @floor = @destination.last
    @destination = []
  end

end