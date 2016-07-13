class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :exit_station

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise "Exceeds limit: #{LIMIT}" if check_limit(money)
    @balance += money
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise 'Balance below minimum fare' if balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    @entry_station = nil
  end

  private

  def check_limit(money)
    (@balance + money) > LIMIT
  end

  def deduct(money)
    @balance -= money
  end
end
