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
        Notify.spit(output)
      end

      # Required as part of the thrift data conversion
      # @since 0.3.3
      def encoding
        Encoding::UTF_8
      end

      # Required as part of the thrift data conversion
      # @since 0.3.3
      def force_encoding(enc)
      end

      # Required as part of the thrift data conversion
      # @since 0.3.3
      def bytesize(enc)
      end
    end
  end
end