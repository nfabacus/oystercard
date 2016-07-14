require_relative 'journey'

class Oystercard

  BALANCE_LIMIT = 90

  attr_reader :balance, :journeys

  def initialize
    self.balance = 0
    self.journeys = []
  end

  def top_up(amount)
    raise "Exceeds max allowed amount of #{BALANCE_LIMIT}" if balance_exceeds_limit?(amount)
    self.balance += amount
  end

  def touch_in(entry_station)
    raise "Balance is below £#{Journey::MINIMUM_FARE}" if balance_enough?
    self.journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    self.journey = Journey.new unless journey
    deduct(Journey::MINIMUM_FARE)
    journey.finish(exit_station)
    save_journey
  end

  def save_journey
    self.journeys << {:entry_station => journey.entry_station, :exit_station => journey.exit_station}
  end

  private

  attr_accessor :journey
  attr_writer :balance, :journeys

  def balance_exceeds_limit?(amount)
    balance + amount > BALANCE_LIMIT
  end

  def balance_enough?
    balance < Journey::MINIMUM_FARE
  end

  def deduct(amount)
    self.balance -= amount
  end

end
