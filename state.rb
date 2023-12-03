require_relative "random_strings"
require_relative "time"

class State
  def initialize()
    @awake = true
    @time = T.now
    @action_stack = []
    @schedule = []
    @lastsleep = T.now
    @lastawake = T.now
  end

  def awaken()
    @awake = true
    @lastawake = @time
    @schedule = []
    message("#{random_goodmorning}, #{random_pet_name}!\nYou've been asleep for #{(@lastawake - @lastsleep).pprint_utc}")
    schedule(@time.after(13_30), "bedtime soon-ish reminder") {
      message("Recommended bedtime at #{@lastawake.after(15_00).pprint}")
    } 
    schedule(@time.after(14_30), "bedtime soon reminder") {
      message("You should go to bed soon")
    } 
  end

  def go_to_bed()
    @awake = false
    @lastsleep = @time
    @schedule = []
    message("You've been up for #{(@lastsleep - @lastawake).pprint_utc}...\n#{random_goodnight}, #{random_pet_name}!")
  end

  def schedule(time, title, &action)
    @schedule << {
      :time => time,
      :title => title,
      :action => action,
      :done => false,
    }
  end

  def advance_time(new_time)
    old_time = @time
    @time = new_time
    @schedule.each do |event|
      if T.is_between?(old_time, @time, event[:time])
        event[:action].call
        event[:done] = true
      end
    end
    @schedule = @schedule.select { |event| !event[:done] }
  end

  def inspect() 
    s_awake =  @awake ? "Awake" : "Asleep"
    "Liz is #{s_awake}
    #{@schedule}
    ".split('    ').join('')
  end

  def set_messenger(messenger)
    @messenger = messenger
  end

  def message(text)
    @messenger&.send_message(text) if @messenger
  end
end

