require 'evertils/common/authentication'

module Evertils
  module Common
    module Entity
      class Base

        def initialize(en = nil)
          if en.is_a?(Authentication)
            @evernote = en
          else
            @evernote = Authentication.new
          end

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
        def start_of_day(date = ::Time.now)
          ::Time.mktime(date.year, date.month, date.day, 12, 0, 0, 0, 0).to_datetime
        end

        #
        # @since 0.2.8
        def end_of_day(date = ::Time.now)
          ::Time.mktime(date.year, date.month, date.day, 23, 59, 59, 0).to_datetime
        end

        #
        # @since 0.2.9
        def prop(name)
          @entity.send(name)
        end

      end
    end
  end
end