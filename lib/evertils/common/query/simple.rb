module Evertils
  module Common
    module Query
      class Simple < Query::Base
        #
        # @since 0.2.0
        def notebooks
          Entity::Notebooks.new.all
        end

        #
        # @since 0.2.0
        def tags
          Entity::Tags.new.all
        end

        #
        # @since 0.2.0
        def notes_by_notebook(name)
          entity = Manager::Notebook.instance
          nb = entity.find(name)
          nb.notes
        end

        #
        # @since 0.2.0
        def create_stack_from_yml(full_path)
          stack = Entity::Stack.new
          stack.create_from_yml(full_path)
        end

        #
        # @since 0.2.0
        def create_note_from_yml(full_path)
          entity = Entity::Note.new
          entity.create_from_yml(full_path)
        end

        #
        # @since 0.2.0
        def create_notebooks_from_yml(full_path)
          entity = Entity::Notebooks.new
          entity.create_from_yml(full_path)
        end

        #
        # @since 0.2.0
        def create_notebook(name, stack = nil)
          entity = Entity::Notebook.new
          entity.create(name, stack)
        end

        #
        # @since 0.3.1
        def create_tag(name)
          entity = Manager::Tag.instance
          entity.create(name)
        end

        #
        # @since 0.3.3
        def create_note_from_hash(conf)
          entity = Manager::Note.instance
          entity.create(conf)
        end
        alias create_note create_note_from_hash

        #
        # @since 0.2.0
        def find_note(name)
          entity = Manager::Note.instance
          entity.find(name)
        end

        #
        # @since 0.3.1
        def find_notebook(name)
          entity = Manager::Notebook.instance
          entity.find(name)
        end

        #
        # @since 0.2.0
        # @deprecated 0.3.1
        def notebook_by_name(name)
          deprecation_notice('0.3.1', 'Replaced by #find_notebook method.  Will be removed in 0.4.0')

          entity = Manager::Notebook.instance
          entity.find(name)
        end

        #
        # @since 0.2.0
        def note_exists(name)
          entity = Manager::Note.instance
          note = entity.find(name)
          note.exists?
        end

        #
        # @since 0.2.0
        def destroy_note(name)
          entity = Manager::Note.instance
          note = entity.find(name)
          note.expunge!
        end

        #
        # @since 0.2.0
        def poll
          sync = Entity::Sync.new
          sync.state
        end
      end
    end
  end
end