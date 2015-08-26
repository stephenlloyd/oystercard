require 'journey'
class JourneyLog
  attr_reader :journeys

  def initialize
    @journeys = []
  end

  def start(station)
    fail 'Already in a Journey.' if current_journey.entry_station
    journeys << Journey.new(entry_station: station)
  end

  def stop(station)
    current_journey.exit_station = station
    current_journey
  end

  private

  def current_journey
    journeys.reject(&:complete?).first || Journey.new
  end
end