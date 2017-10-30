module Evertils
  module Common
    class ENMLElement
      #
      # @since 0.3.3
      def initialize(colour)
        @colour = colour
        @enml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
        @enml += "<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"
      end

      #
      # @since 0.3.3
      def body=(content)
        @enml += "<en-note bgcolor=\"##{@colour.to_s(16)}\">#{content}</en-note>"
      end

      #
      # @since 0.3.3
      def to_s
        @enml.to_s.encode(Encoding::UTF_8)
      end

      # Required as part of the thrift data conversion
      # @since 0.3.3
      def encoding
        Encoding::UTF_8
      end

      # Required as part of the thrift data conversion
      # @since 0.3.3
      def force_encoding(enc)
        @enml.to_s.encode(enc)
      end
    end
  end
end