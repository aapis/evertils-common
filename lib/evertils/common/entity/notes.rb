require 'evertils/common/authentication'

module Evertils
  module Common
    module Entity
      class Notes
        
        def initialize
          @evernote = Authentication.new.store

          self
        end

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