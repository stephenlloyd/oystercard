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
    exit_station.respond_to?(:zone)
  end

  private
  DESCENDING = Proc.new {|item_a,item_b| item_b <=> item_a }

  def zones
    [entry_station, exit_station].map(&:zone).sort(&DESCENDING)
  end

end