require 'balance_error'
class OysterCard
  attr_reader :balance, :journeys
  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize(journey_log:)
    @balance = 0
    @journeys = journey_log
  end

  def top_up(amount)
    fail(BalanceError, "You have exceeded your #{BALANCE_LIMIT} allowance.") if (amount + balance) > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail(BalanceError, "You don't have enough.") if balance < MINIMUM_CHARGE
    journeys.start(station)
  end

  def touch_out(station)
    journey = journeys.stop(station)
    deduct(journey.fare)
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end