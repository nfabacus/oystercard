class Oystercard
  LIMIT = 90
  MIN_BALANCE = 1

  attr_reader :balance, :entry_station


  def initialize
    @balance = 0
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

  def touch_out
    deduct(MIN_BALANCE)
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
