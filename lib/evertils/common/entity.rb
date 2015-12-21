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

      end
    end
  end
end