module Evertils
  module Common
    module Entity
      class Notes < Entity::Base

        def findAll(title, notebook = nil)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "intitle:#{title}" if title
          filter.notebookGuid = notebook if notebook

          @evernote.call(:findNotesMetadata, filter, nil, 300)
        end

        def findOne(title, notebook = nil)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "intitle:#{title}" if title
          filter.notebookGuid = notebook if notebook

          @evernote.call(:findNotesMetadata, filter, nil, 1)
        end

        def last_year
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "created:year-1"

          @evernote.call(:findNotesMetadata, filter, nil, 300)
        end

        def last_month
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "created:month-1"

          @evernote.call(:findNotesMetadata, filter, nil, 300)
        end

        def last_week
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "created:week-1"

          @evernote.call(:findNotesMetadata, filter, nil, 300)
        end

        def yesterday
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "created:day-1"

          @evernote.call(:findNotesMetadata, filter, nil, 300)
        end

      end
    end
  end
end