module Evertils
  module Common
    module Converter
      class Base
        
        #
        # @since 0.2.8
        def deprecation_notice(version, message)
          output = "Deprecated as of #{version}"
          output += "\nReason: #{message}" if message
          output
        end

      end
    end
  end
end