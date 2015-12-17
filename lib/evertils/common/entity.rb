require 'evertils/common/authentication'

module Evertils
  module Common
    module Entity
      class Base

        def initialize
          @evernote = Authentication.new.store
          self
        end

        def has_required_fields(hash, required)
          hash.keys.each do |key|
            required.include? key
          end
        end

      end
    end
  end
end