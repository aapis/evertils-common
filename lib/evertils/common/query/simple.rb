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
          entity = Manager::Notebook.new
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
        end

        #
        # @since 0.2.0
        def create_notebooks_from(full_path)
          entity = Entity::Notebooks.new
          nb = entity.create_from_yml(full_path)
        end

        #
        # @since 0.2.0
        def create_notebook(name, stack = nil)
          entity = Entity::Notebook.new
          nb = entity.create(name, stack)
        end

        #
        # @since 0.3.1
        def create_tag(name)
          entity = Manager::Tag.new
          tag = entity.create(name)
        end

        #
        # @since 0.2.0
        def create_note(title, body, p_notebook_name = nil, file = nil, share_note = false, created_on = nil)
          entity = Manager::Note.new
          conf = { name: title, body: body, notebook: p_notebook_name, files: file, shared: share_note, created_on: created_on }
          note = entity.create(conf)
        end

        #
        # @since 0.2.0
        def find_note(title_filter = nil, notebook_filter = nil)
          entity = Manager::Note.new
          note = entity.find(title_filter, notebook_filter)
        end

        #
        # @since 0.3.1
        def find_notebook(name)
          entity = Manager::Notebook.new
          nb = entity.find(name)
        end

        #
        # @since 0.2.0
        # @deprecated 0.3.1
        def notebook_by_name(name)
          deprecation_notice('0.3.1', 'Replaced by #find_notebook method.  Will be removed in 0.4.0')

          entity = Manager::Notebook.new
          nb = entity.find(name)
        end

        #
        # @since 0.2.0
        def note_exists(name)
          entity = Manager::Note.new
          note = entity.find(name)
          note.exists?
        end

        #
        # @since 0.2.0
        def destroy_note(name)
          entity = Manager::Note.new
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