module Evertils
  module Common
    module Entity
      class Base < Common::Generic
        attr_accessor :entity

        REPLACEMENTS = {
          '%DOY%': Date.today.yday,
          '%MONTH_NAME%': Date.today.strftime('%B'),
          '%MONTH%': Date.today.month,
          '%DAY%': Date.today.day,
          '%DOW%': Date.today.wday,
          '%DOW_NAME%': Date.today.strftime('%a'),
          '%YEAR%': Date.today.year,
          '%WEEK%': Date.today.cweek
        }

        def initialize
          @evernote = Authentication.instance

          super
        end

        def placeholders_for(items)
          items.map do |item|
            REPLACEMENTS.each_pair do |k, v|
              item.last.gsub!(k.to_s, v.to_s) if item.last.is_a? String
              item.last.map { |i| i.gsub!(k.to_s, v.to_s) } if item.last.is_a? Array
            end
          end

          symbolize_keys(items)
        end

        def symbolize_keys(hash)
          hash.inject({}){ |result, (key, value)|
            new_key = case key
                      when String then key.to_sym
                      else key
                      end
            new_value = case value
                        when Hash then symbolize_keys(value)
                        else value
                        end
            result[new_key] = new_value
            result
          }
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