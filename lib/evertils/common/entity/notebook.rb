require 'evertils/common/entity/notebooks'

module Evertils
  module Common
    module Entity
      class Notebook < Entity::Base

        def find(name)
          @notebook = nil
          notebooks = Notebooks.new.all

          notebooks.each do |notebook|
            if notebook.name == name.to_s
              @notebook = notebook
            end
          end

          @notebook
        end

        def create(name, stack = nil)
          notebook = ::Evernote::EDAM::Type::Notebook.new
          notebook.name = name
          
          if !stack.nil?
            notebook.stack = stack
            notebook.name = "#{stack}/#{name}"
          end
          
          @evernote.createNotebook(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, notebook)
        end

        def expunge(name)
          nb = find(name)

          @evernote.expungeNotebook(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, nb.guid)
        end

        def notes(guid = nil)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.notebookGuid = @notebook.guid

          notes = Notes.new
          notes.find(nil, @notebook.guid)
        end

      end
    end
  end
end