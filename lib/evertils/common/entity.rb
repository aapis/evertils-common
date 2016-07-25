module Evertils
  module Common
    module Entity
      class Base < Common::Generic

        attr_accessor :evernote, :entity

        def initialize
          @evernote = Authentication.instance

          super
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

        #
        # @since 0.3.2
        def to_s
          prop(:guid)
        end

      end
    end
  end
end