class Oystercard

  attr_reader :balance, :card_status, :entry_station

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @card_status = "Not in use"
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Not enough funds" if @balance < MIN_FARE
    @card_status = "In use"
    @entry_station = station
  end

  def in_journey?
    # if @entry_station.nil?
    #
    if card_status == "In use"
      true
    else
      false
    end
  end

  def touch_out
    deduct(MIN_FARE)
    @card_status = "Not in use"
    @entry_station = nil
  end

  private
  def deduct(fare)
    @balance -= fare
  end
end
