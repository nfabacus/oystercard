class Oystercard

LIMIT = 90

attr_accessor :balance

def initialize
  @balance = 0
end

def top_up(amount)
  raise "Top up would exceed card limit of £#{LIMIT}" if (amount + @balance) > LIMIT 
  @balance += amount
end

end
