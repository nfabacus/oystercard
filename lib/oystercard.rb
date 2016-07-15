require_relative 'station'
require_relative 'journey'

class Oystercard
  LIMIT = 90

  attr_accessor :journey
  attr_reader :balance, :entry_station, :exit_station

  def initialize
    @balance = 0
    @journey = []
  end

  def top_up(money)
    raise "Exceeds limit: #{LIMIT}" if check_limit(money)
    @balance += money
  end


  def touch_in(station)
    raise 'Balance below minimum fare' if balance < Journey::MINIMUM_FARE
    @entry_station = station
    self.journey = Journey.new(station)
  end

  def touch_out(station)
    deduct(Journey::MINIMUM_FARE)
    @exit_station = station
    self.journey.finished_journey(station)
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
