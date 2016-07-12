class Oystercard

  attr_reader :balance
  attr_reader :card_status

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @card_status = "Not in use"
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    fail "Not enough funds" if @balance < MIN_BALANCE
    @card_status = "In use"
  end

  def in_journey?
    if card_status == "In use"
      true
    else
      false
    end
  end

  def touch_out
    @card_status = "Not in use"
  end
end
