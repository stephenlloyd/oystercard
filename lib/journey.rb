class Journey

  attr_accessor :entry_station, :exit_station

  PENALTY_FARE = 10

  def initialize(entry_station: nil, exit_station: nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    PENALTY_FARE
  end


end