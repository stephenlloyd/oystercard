require 'journey'
class JourneyLog

  def initialize
    @journeys = []
    @current_journey = false
  end

  def start(station)
    all << Journey.new(entry_station: station)
    self.current_journey = true
  end

  def stop(station)
    if current_journey?
      all.last.exit_station = station
      self.current_journey = false
    else
      all << Journey.new(exit_station: station)
    end
    all.last
  end

  def all
    @journeys
  end

  private

  attr_writer :current_journey

  def current_journey?
    @current_journey
  end
end