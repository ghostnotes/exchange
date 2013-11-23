module Exchange
  DEFAULT_TIME_ZONE = 'Asia/Tokyo'

  class DayChecker
    def self.is_available_wday?(today)
      return !today.saturday? && !today.sunday?
    end
  end

  class TimeChecker
    DEFAULT_START_TIME_HOUR = 9.hour;
    DEFAULT_END_TIME_HOUR = 24.hour;

    @@options = {
      start_time_hour: DEFAULT_START_TIME_HOUR,
      end_time_hour: DEFAULT_END_TIME_HOUR,
      time_zone: DEFAULT_TIME_ZONE
    }

    def self.options
      @@options
    end

    def self.options=(opts)
      @@options = opts
    end

    def self.is_available_time?(opts = {})
      if opts.key?(:start_time_hour)
        start_time_hour = opts[:start_time_hour]
      else
        start_time_hour = @@options[:start_time_hour]
      end

      if opts.key?(:end_time_hour)
        end_time_hour = opts[:end_time_hour]
      else
        end_time_hour = @@options[:end_time_hour]
      end

      if opts.key?(:time_zone)
        time_zone = opts[:time_zone]
      else
        time_zone = @@options[:time_zone]
      end

      available_hours = start_time_hour..end_time_hour
      current_hour = Time.now.in_time_zone(time_zone).hour
      return available_hours.include?(current_hour.hour)
    end

  end
end