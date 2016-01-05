module Evertils
  module Common
    class Generic

      #
      # @since 0.3.2
      def initialize
        self
      end

      #
      # @since 0.3.2
      def has_required_fields(hash, required)
        hash.keys.each do |key|
          required.include? key
        end
      end

      #
      # @since 0.3.2
      def deprecation_notice(version, message)
        output = "Deprecated as of #{version}"
        output += "\nReason: #{message}" if message
        output
      end

    end
  end
end