module Evertils
  module Common
    module Entity
      class Tags < Entity::Base
        def all
          @evernote.call(:listTags)
        end
      end
    end
  end
end