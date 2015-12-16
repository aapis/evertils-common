require 'evertils/common/authentication'

module Evertils
  module Common
    module Entity
      class Notebooks
        
        def initialize
          @evernote = Authentication.new.store

          self
        end

        def all
          @evernote.listNotebooks(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN)
        end

      end
    end
  end
end