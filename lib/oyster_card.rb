class OysterCard

  attr_reader :balance, :entry_station, :journey
  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize(journey:)
    @balance = 0
    @in_journey = false
    @journey = journey
  end

  def top_up(amount)
    raise "You have exceeded your #{BALANCE_LIMIT} allowance." if (amount + balance) > BALANCE_LIMIT
    @balance += amount
  end

  def deduct(amount)
    raise "You don't have enough." if (balance - amount) < 0
    @balance -= amount
  end

  def in_journey?
    !entry_station.nil?
  end

  def touch_in(station)
    raise "You don't have enough." if balance < MINIMUM_CHARGE
    self.entry_station = station
  end

  def journeys
    @journeys ||= []
  end

  def touch_out(station)
    journeys << journey.new({entry_station: entry_station, exit_station: station })
    deduct(journeys.last.fare)
    self.entry_station = nil
  end

  private
  attr_writer :entry_station

end