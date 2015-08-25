class OysterCard

  attr_reader :balance, :entry_station, :journey
  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize(journey:)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    fail "You have exceeded your #{BALANCE_LIMIT} allowance." if (amount + balance) > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    validate_entry
    self.entry_station = station
    record_journey
  end

  def touch_out(station)
    record_journey
    current_journey.exit_station = station
    complete_journey
  end

  def journeys
    @journeys ||= []
  end

  private

  attr_writer :entry_station

  def deduct(amount)
    fail "You don't have enough." if (balance - amount) < 0
    @balance -= amount
  end

  def in_journey?
    !entry_station.nil?
  end

  def complete_journey
    deduct(current_journey.fare)
    self.entry_station = nil
  end

  def current_journey
    return journeys.last unless (journeys.empty? || in_journey?)
    journey.new({entry_station: entry_station, exit_station: nil })
  end

  def record_journey
    return current_journey if journeys.include?(current_journey)
    (journeys << current_journey).last
  end

  def validate_entry
    fail "Already touched in." if in_journey?
    fail "You don't have enough." if balance < MINIMUM_CHARGE
  end

end