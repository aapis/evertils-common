require 'evertils/common/authentication'

module Evertils
  module Common
    module Entity
      class Base

        def initialize
          @evernote = Authentication.new
          self
        end

        def has_required_fields(hash, required)
          hash.keys.each do |key|
            required.include? key
          end
        end

        #
        # @since 0.2.8
        def deprecation_notice(version)
          puts "Deprecated as of #{version}"
        end

        #
        # @since 0.2.8
        def start_of_day(date = nil)
          date = ::Time.now unless date

          ::Time.mktime(date.year, date.month, date.day, 12, 0, 0, 0, 0).to_datetime
        end

        #
        # @since 0.2.8
        def end_of_day(date = nil)
          date = ::Time.now unless date
          
          ::Time.mktime(date.year, date.month, date.day, 23, 59, 59, 0).to_datetime
        end

      end
    end
  end
end