class Oystercard

LIMIT = 90

attr_accessor :balance

def initialize
  @balance = 0
end

def top_up(amount)
  error = "Top up would exceed card limit of £#{LIMIT}"
  raise error if (amount + @balance) > LIMIT
  @balance += amount
end

def deduct(amount)
  @balance -= amount
end

def touch_in
  @in_journey = true
end

def touch_out
  @in_journey = false
end

def in_journey?
  @in_journey
end
end
