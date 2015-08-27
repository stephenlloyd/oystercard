require 'forwardable'
class JourneyLog
  extend Forwardable

  def_delegator :current_journey, :exit, :end_journey

  def initialize(journey_klass: )
    @journey_klass = journey_klass
    @journeys = []
  end

  def start_journey(station)
    fail 'Already in a Journey.' if current_journey.entry_station
    add(journey_klass.new(entry_station: station))
  end

  def journeys
    @journeys.dup
  end

  private
  attr_reader :journey_klass

  def current_journey
    journeys.reject(&:complete?).first || journey_klass.new
  end

  def add(journey)
    @journeys << journey
  end

end