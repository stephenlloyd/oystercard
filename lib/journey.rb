class Journey

  attr_accessor :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize(entry_station: nil, exit_station: nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    zones.inject(:-) + 1 rescue PENALTY_FARE
  end

  private

  def zones
    [entry_station.zone, exit_station.zone].sort{|a,b|b <=> a}
  end


end