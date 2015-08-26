class Journey
  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize(entry_station: nil)
    @entry_station = entry_station
  end

  def exit(station)
    @exit_station = station
    self
  end

  def fare
    return PENALTY_FARE unless entry_station && exit_station
    zones.inject(:-) + 1
  end

  def complete?
    !exit_station.nil?
  end

  private

  def zones
    [entry_station, exit_station].map(&:zone).sort{|a,b| b <=> a }
  end

end