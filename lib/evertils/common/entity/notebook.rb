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
          
          @evernote.call(:createNotebook, notebook)
        end

        def expunge(name)
          nb = find(name)

          @evernote.call(:expungeNotebook, nb.guid)
        end

        #
        # @since 0.2.9
        def destroy(name)
          nb = find(name)

          move_to('Trash', nb)
        end

        #
        # @since 0.2.9
        def move_to(notebook, note)
          
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