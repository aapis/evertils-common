require 'evertils/common/authentication'

module Evertils
  module Common
    module Entity
      class Notes
        
        def initialize
          @evernote = Authentication.new.store

          self
        end

        def all
          @evernote.listNotebooks(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN)
        end

        def by_notebook(notebook)

        end

        def by_stack(stack)

        end

        def find(title, notebook)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "intitle:#{title}" if title
          filter.notebookGuid = notebook if notebook

          @evernote.findNotes(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, filter, nil, 300)
        end

      end
    end
  end
end