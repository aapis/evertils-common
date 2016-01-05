module Evertils
  module Common
    module Query
      class Base < Common::Generic

        #
        # @since 0.2.8
        def start_of_day(date = nil)
          date = ::Time.now unless date

          ::Time.mktime(date.year, date.month, date.day, 12, 0, 0).to_datetime
        end

        #
        # @since 0.2.8
        def end_of_day(date = nil)
          date = ::Time.now unless date
          
          ::Time.mktime(date.year, date.month, date.day, 23, 59, 59).to_datetime
        end

      end
    end
  end
end