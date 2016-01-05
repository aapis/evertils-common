require 'evertils/common/entity/notebooks'

module Evertils
  module Common
    module Entity
      class Notebook < Entity::Base

        #
        # @since 0.2.0
        def find(name)
          @entity = nil
          notebooks = Notebooks.new.all

          @entity = notebooks.detect { |nb| nb.name == name }

          self if @entity
        end

        #
        # @since 0.2.0
        def create(name, stack = nil)
          @entity = nil

          notebook = ::Evernote::EDAM::Type::Notebook.new
          notebook.name = name
          
          if !stack.nil?
            notebook.stack = stack
            notebook.name = "#{stack}/#{name}"
          end
          
          @entity = @evernote.call(:createNotebook, notebook)

          self if @entity
        end

        #
        # @since 0.2.0
        def default
          @entity = @evernote.call(:getDefaultNotebook)

          self if @entity
        end

        #
        # @since 0.2.9
        def expunge!
          @evernote.call(:expungeNotebook, @entity.guid)
        end

        #
        # @since 0.2.0
        # @deprecated 0.2.9
        def expunge
          deprecation_notice('0.2.9', 'Replaced with Entity#expunge!  Will be removed in 0.4.0.')

          @evernote.call(:expungeNotebook, @entity.guid)
        end

        #
        # @since 0.2.0
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