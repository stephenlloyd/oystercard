#The purpose of this class is to represent a station with a name and zone

class Station
  attr_reader :name, :zone

  def initialize(name:, zone:)
    @name, @zone = name, zone
  end

end