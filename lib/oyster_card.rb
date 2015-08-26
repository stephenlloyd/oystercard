class OysterCard
  attr_reader :balance, :journeys
  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize(journey_log:)
    @balance = 0
    @journeys = journey_log
  end

  def top_up(amount)
    fail "You have exceeded your #{BALANCE_LIMIT} allowance." if (amount + balance) > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "You don't have enough." if balance < MINIMUM_CHARGE
    journeys.start(station)
  end

  def touch_out(station)
    deduct(journeys.stop(station).fare)
  end

  private

  def deduct(amount)
    fail "You don't have enough." if (balance - amount) < 0
    @balance -= amount
  end

  def in_journey?
    journeys.all.reject(&:complete?).any?
  end

end