class JourneyLog
  attr_reader :journeys

  def initialize(journey_klass: )
    @journey_klass = journey_klass
    @journeys = []
  end

  def start(station)
    fail 'Already in a Journey.' if current_journey.entry_station
    journeys << journey_klass.new(entry_station: station)
  end

  def stop(station)
    current_journey.exit(station)
  end

  private
  attr_reader :journey_klass

  def current_journey
    journeys.reject(&:complete?).first || journey_klass.new
  end

end