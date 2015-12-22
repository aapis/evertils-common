module Evertils
  module Common
    module Entity
      class Notes < Entity::Base

        def find_all(title, notebook = nil)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "intitle:#{title}" if title
          filter.notebookGuid = notebook if notebook

          spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          spec.includeTitle = true

          response = @evernote.call(:findNotesMetadata, filter, nil, 300, spec)
          response.notes
        end

        def find_one(title, notebook = nil)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "intitle:#{title}" if title
          filter.notebookGuid = notebook if notebook

          spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          spec.includeTitle = true

          response = @evernote.call(:findNotesMetadata, filter, nil, 1, spec)
          response.notes
        end

      end
    end
  end
end