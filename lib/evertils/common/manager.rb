require 'evertils/common/authentication'

module Evertils
  module Common
    module Manager
      class Base

        attr_accessor :api

        #
        # @since 0.3.0
        def initialize
          @api = Authentication.instance

          self
        end

        #
        # @since 0.3.0
        def has_required_fields(hash, required)
          hash.keys.each do |key|
            required.include? key
          end
        end

        #
        # @since 0.3.0
        def deprecation_notice(version, message)
          output = "Deprecated as of #{version}"
          output += "\nReason: #{message}" if message
          output
        end

      end
    end
  end
end