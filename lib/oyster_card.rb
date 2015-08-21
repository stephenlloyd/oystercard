class OysterCard

  attr_reader :balance, :entry_station
  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @in_journey = false
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
    @in_journey
  end

  def touch_in(station)
    raise "You don't have enough." if balance < MINIMUM_CHARGE
    self.in_journey = true
    self.entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    self.in_journey = false
  end



  private
  attr_writer :in_journey, :entry_station


end