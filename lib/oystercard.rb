class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :station, :journeys

  def initialize
    self.balance = 0
    self.journeys = []
  end

  def top_up(amount)
    raise "Exceeds max allowed amount of #{BALANCE_LIMIT}" if balance_exceeds_limit?(amount)
    self.balance += amount
  end

  def touch_in(entry_station)
    raise "Balance is below £#{MINIMUM_FARE}" if balance_enough?
    self.station = entry_station
    self.entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    self.exit_station = exit_station
    save_journey
  end

  def in_journey?
    self.station != nil
  end

  def save_journey
    self.journeys << {:entry_station => entry_station, :exit_station => exit_station}
    self.station = nil
  end

  private

  attr_accessor :entry_station, :exit_station
  attr_writer :balance, :station, :journeys

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
