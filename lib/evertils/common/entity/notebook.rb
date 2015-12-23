require 'evertils/common/entity/notebooks'

module Evertils
  module Common
    module Entity
      class Notebook < Entity::Base

        def find(name)
          @entity = nil
          notebooks = Notebooks.new.all

          notebooks.each do |notebook|
            if notebook.name == name.to_s
              @entity = notebook
            end
          end

          self if @entity
        end

        def create(name, stack = nil)
          @entity = nil

          notebook = ::Evernote::EDAM::Type::Notebook.new
          notebook.name = name
          
          if !stack.nil?
            notebook.stack = stack
            notebook.name = "#{stack}/#{name}"
          end
          
          begin
            @entity = @evernote.call(:createNotebook, notebook)
          rescue Evernote::EDAM::Error::EDAMUserException => e
            puts e.inspect
          end

          self if @entity
        end

        def default
          @entity = @evernote.call(:getDefaultNotebook)

          self if @entity
        end

        def expunge!
          @evernote.call(:expungeNotebook, @entity.guid)
        end

        def expunge
          deprecation_notice('0.2.9')

          @evernote.call(:expungeNotebook, @entity.guid)
        end

        def notes
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.notebookGuid = @entity.guid

          notes = Notes.new
          notes.find(nil, @entity.guid)
        end

      end
    end
  end
end