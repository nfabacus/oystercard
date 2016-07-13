class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Exceeds max allowed amount of #{BALANCE_LIMIT}" if balance_exceeds_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise 'Balance is below £1, unable to touch in' if balance_enough?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def balance_exceeds_limit?(amount)
    balance + amount > BALANCE_LIMIT
  end

  def balance_enough?
    balance < MINIMUM_FARE
  end

end
