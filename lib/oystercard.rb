class Oystercard
  LIMIT = 90
  MIN_BALANCE = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys


  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    error = "Top up would exceed card limit of £#{LIMIT}"
    raise error if balance_limit_exceeded?(amount)
    @balance += amount
  end


  def touch_in(station)
    error = 'Insufficient balance'
    raise error if insufficient_balance?
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_BALANCE)
    @exit_station = station
    @journeys << {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end



  private

  def balance_limit_exceeded?(amount)
    (amount + @balance) > LIMIT
  end

  def insufficient_balance?
    @balance < MIN_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

end
