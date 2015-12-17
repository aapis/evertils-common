module Evertils
  module Common
    module Entity
      class Notes < Entity::Base

        def findAll(title, notebook = nil)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "intitle:#{title}" if title
          filter.notebookGuid = notebook if notebook

          @evernote.findNotes(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, filter, nil, 300)
        end

        def findOne(title, notebook = nil)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "intitle:#{title}" if title
          filter.notebookGuid = notebook if notebook

          @evernote.findNotes(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, filter, nil, 1)
        end

      end
    end
  end
end