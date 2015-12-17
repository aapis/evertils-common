module Evertils
  module Common
    module Entity
      class Sync < Entity::Base

        def state
          @evernote.getSyncState(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN)
        end

      end
    end
  end
end