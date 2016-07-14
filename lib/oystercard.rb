require_relative 'station'

class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :exit_station, :journey

  def initialize
    @balance = 0
    @journey = []
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
    store_journey
  end

  private

  def check_limit(money)
    (@balance + money) > LIMIT
  end

  def deduct(money)
    @balance -= money
  end

  def store_journey
   journey << {:entry_station => @entry_station, :exit_station => @exit_station}
  end
end
