module Evertils
  module Common
    module Entity
      class Tags < Entity::Base

        def all
          @evernote.listTags(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN)
        end

      end
    end
  end
end