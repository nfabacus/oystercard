class Oystercard
LIMIT = 90
MINIMUM_FARE = 1
attr_reader :balance

def initialize
  @balance = 0
  @in_journey = false
end

def top_up(money)
  raise "Exceeds limit: #{LIMIT}" if check_limit(money)
  @balance += money
end

def deduct(money)
  @balance -= money
end

def in_journey?
  @in_journey
end

def touch_in
  raise "Balance below minimum fare" if balance < MINIMUM_FARE
  @in_journey = true
end

def touch_out
  @in_journey = false
end

private

def check_limit(money)
  (@balance + money)> LIMIT
end

end
