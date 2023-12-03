class T
  attr_accessor :time

  def initialize(time)
    @time = time
  end

  def self.now()
    T.new(Time.now)
  end

  def self.from(t)
    T.new(t.time)
  end

  def after(time)
    hours, minutes = HH_MM time
    T.new(@time + hours*3600 + minutes*60)
  end

  def self.is_between?(boundA, boundB, event)
    boundA.time < event.time && event.time < boundB.time or
    boundA.time > event.time && event.time > boundB.time
  end

  def -(time)
    T.new(Time.at(@time - time.time))
  end

  def HH_MM(time)
    time_str = time.to_s
    length = time_str.length

    if length == 1 || length == 2
      [0, time]
    else
      hour = time_str[0..-3].to_i
      minute = time_str[-2..-1].to_i
      [hour, minute]
    end
  end

  def pprint()
    time = @time.utc + 6*3600
    "#{time.hour}:#{time.min <= 9 ? "0" : ''}#{time.min}"
  end

  def pprint_utc()
    time = @time.utc
    "#{time.hour}:#{time.min <= 9 ? "0" : ''}#{time.min}"
  end

  def inspect()
    "<T #{@time}>"
  end
end

