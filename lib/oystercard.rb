class Oystercard

  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    # fail "Maximum balance exceeded" if balance + value > 90
    fail "Maximum balance exceeded" if balance + amount > MAX_BALANCE
    @balance += amount
  end

end
