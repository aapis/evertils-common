module Evertils
  module Common
    module Entity
      class Notes < Entity::Base

        def findAll(title, notebook = nil)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "intitle:#{title}" if title
          filter.notebookGuid = notebook if notebook

          @evernote.call(:findNotes, filter, nil, 300)
        end

        def findOne(title, notebook = nil)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "intitle:#{title}" if title
          filter.notebookGuid = notebook if notebook

          @evernote.call(:findNotes, filter, nil, 1)
        end

      end
    end
  end
end