require 'evertils/common/authentication'

module Evertils
  module Common
    module Entity
      class Sync
        
        def initialize
          @evernote = Authentication.new.store

          self
        end

        def state
          @evernote.getSyncState()
        end

      end
    end
  end
end