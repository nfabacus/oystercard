class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :station

  def initialize
    self.balance = 0
  end

  def top_up(amount)
    raise "Exceeds max allowed amount of #{BALANCE_LIMIT}" if balance_exceeds_limit?(amount)
    self.balance += amount
  end

  def touch_in(station)
    raise 'Balance is below £1, unable to touch in' if balance_enough?
    self.station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    self.station = nil
  end

  def in_journey?
    self.station != nil
  end

  private

  attr_writer :balance, :station

  def balance_exceeds_limit?(amount)
    balance + amount > BALANCE_LIMIT
  end

  def balance_enough?
    balance < MINIMUM_FARE
  end

  def deduct(amount)
    self.balance -= amount
  end

end
