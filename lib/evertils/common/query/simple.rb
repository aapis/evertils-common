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
        def notebook_by_name(name)
          entity = Entity::Notebook.new
          nb = entity.find(name)
          nb.entity
        end

        #
        # @since 0.2.0
        def notes_by_notebook(name)
          entity = Entity::Notebook.new
          nb = entity.find(name)
          nb.notes
        end

        #
        # @since 0.2.0
        def create_stack_from(full_path)
          stack = Entity::Stack.new
          stack.create_from_yml(full_path)
        end

        #
        # @since 0.2.0
        def create_note_from(full_path)
          entity = Entity::Note.new
          note = entity.create_from_yml(full_path)
          note.entity
        end

        #
        # @since 0.2.0
        def create_notebooks_from(full_path)
          entity = Entity::Notebooks.new
          nb = entity.create_from_yml(full_path)
          nb.entity
        end

        #
        # @since 0.2.0
        def create_notebook(name, stack = nil)
          entity = Entity::Notebook.new
          nb = entity.create(name, stack)
          nb.entity
        end

        #
        # @since 0.2.0
        def find_note(title_filter = nil, notebook_filter = nil)
          entity = Entity::Note.new
          note = entity.find(title_filter, notebook_filter)
          note.entity
        end

        #
        # @since 0.2.0
        def note_exists(name)
          entity = Entity::Note.new
          note = entity.find(name)
          note.exists?
        end

        #
        # @since 0.2.0
        def create_note(title, body, p_notebook_name = nil, file = nil, share_note = false, created_on = nil)
          entity = Entity::Note.new
          note = nm.create(title, body, p_notebook_name, file, share_note, created_on)
          note.entity
        end

        #
        # @since 0.2.0
        def destroy_note(name)
          entity = Entity::Note.new
          note = entity.find(name)
          note.expunge!
        end

        #
        # @since 0.2.0
        def poll
          begin
            sync = Entity::Sync.new
            sync.state
          rescue Evernote::EDAM::Error::EDAMSystemException => e
            if e.errorCode == 19
              puts "You're rate limited, wait #{e.rateLimitDuration}s"
            end
          end
        end

      end
    end
  end
end