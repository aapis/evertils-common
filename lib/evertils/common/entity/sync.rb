module Evertils
  module Common
    module Entity
      class Sync < Entity::Base

        def state
          @evernote.call(:getSyncState)
        end

      end
    end
  end
end