module Evertils
  module Common
    module Converter
      class Base
        
        #
        # @since 0.2.8
        def deprecation_notice(version)
          puts "Deprecated as of #{version}"
        end

      end
    end
  end
end