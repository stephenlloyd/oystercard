class OysterCard

  attr_reader :balance
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1

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

  def touch_in
    raise "You don't have enough." if balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end


end