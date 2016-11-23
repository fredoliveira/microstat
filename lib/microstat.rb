require "redis"

class Microstat
  def initialize(redis: "redis://localhost:6379", namespace: 'mstat')
    @redis = Redis.new(url: redis)
    @key_space = "#{namespace}:events"
  end

  # Lists the known event types
  def events
    @redis.smembers @key_space
  end

  # Increments a specific event's count, returns the total
  def track(event_name)
    # Add the event to the known event space
    @redis.sadd @key_space, event_name

    # Add today as one of the tracked dates for this event
    @redis.sadd "#{@key_space}:#{event_name}:dates", timestamp_today

    # Increment event count for the current date
    @redis.incr "#{@key_space}:#{event_name}:#{timestamp_today}"

    # Increvent total event count, return it
    @redis.incr "#{@key_space}:#{event_name}:total"
  end

  # Given an event type, return an array of dates where we have data
  def dates(event_name)
    @redis.smembers "#{@key_space}:#{event_name}:dates"
  end

  # Return today's count for an event
  def today(event_name)
    @redis.get "#{@key_space}:#{event_name}:#{timestamp_today}"
  end

  # Returns a count for an arbitrary date string in the yyyymmdd format
  def date(event_name, date_string)
    @redis.get "#{@key_space}:#{event_name}:#{date_string}"
  end

  # Returns a hash with date:count tuples for a given event
  def history(event_name)
    historical_counts = {}

    for date in dates(event_name)
      historical_counts[date] = date(event_name, date)
    end

    return historical_counts
  end

  # Return the total count for an event
  def total(event_name)
    @redis.get "#{@key_space}:#{event_name}:total"
  end

  private

  # Returns the current date timestamp as a string for key matching
  def timestamp_today
    # Grab current timestamp and format as YYYYMMDD
    Time.new.strftime("%Y%m%d")
  end
end
