class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :journeys, :journey

  def initialize
    self.balance = 0
    self.journeys = []
    self.journey = Journey.new
  end

  def top_up(amount)
    raise "Exceeds max allowed amount of #{BALANCE_LIMIT}" if balance_exceeds_limit?(amount)
    self.balance += amount
  end

  def touch_in(entry_station)
    raise "Balance is below £#{MINIMUM_FARE}" if balance_enough?
    self.journey.start(entry_station)

  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    self.journey.finish(exit_station)
    save_journey
  end

  def save_journey
    self.journeys << {:entry_station => journey.entry_station, :exit_station => journey.exit_station}
  end

  private
  attr_writer :balance, :journeys, :journey

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
