module Evertils
  module Common
    module Entity
      class Note < Entity::Base

        #
        # @since 0.2.0
        def create_from_yml(full_path)
          begin
            if File.exist? full_path
              conf = YAML::load(File.open(full_path))
              required = %w(title body)

              if has_required_fields(conf, required)
                create(conf['title'], conf['body'], conf['parent'])
              else
                raise ArgumentError, 'Configuration file is missing some required fields'
              end
            else
              raise ArgumentError, "File not found: #{full_path}"
            end
          rescue ArgumentError => e
            puts e.message
          end
        end

        #
        # @since 0.2.0
        def create(title, body, parent_notebook = nil, file = nil, share_note = false, created_on = nil)
          @entity = nil

          # final output
          output = {}

          # Create note object
          our_note = ::Evernote::EDAM::Type::Note.new
          our_note.resources = []
          our_note.tagNames = []

          # a file was requested, lets prepare it for storage
          if file
            if file.is_a? Array
              file.each do |f|
                media_resource = ENML.new(f)
                body.concat(media_resource.embeddable_element)
                our_note.resources << media_resource.element
              end
            else
              media_resource = ENML.new(file)
              body.concat(media_resource.embeddable_element)
              our_note.resources << media_resource.element
            end
          end

          # only join when required
          body = body.join if body.is_a? Array

          n_body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
          n_body += "<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"
          n_body += "<en-note>#{body}</en-note>"
         
          # setup note properties
          our_note.title = title
          our_note.content = n_body
          our_note.created = created_on if !created_on.is_a?(DateTime)

          if !parent_notebook.is_a? Evertils::Common::Entity::Notebook
            nb = Entity::Notebook.new
            parent_notebook = nb.find(parent_notebook)
            parent_notebook = nb.default if parent_notebook.nil?
          end
          
          # parent_notebook is optional; if omitted, default notebook is used
          our_note.notebookGuid = parent_notebook.prop(:guid)

          # Attempt to create note in Evernote account
          begin
            @entity = @evernote.call(:createNote, our_note)
            share if share_note
          rescue ::Evernote::EDAM::Error::EDAMUserException => edue
            ## Something was wrong with the note data
            ## See EDAMErrorCode enumeration for error code explanation
            ## http://dev.evernote.com/documentation/reference/Errors.html#Enum_EDAMErrorCode
            Notify.error "EDAMUserException: #{edue}\nCode #{edue.errorCode}: #{edue.parameter}"
          rescue ::Evernote::EDAM::Error::EDAMNotFoundException
            ## Parent Notebook GUID doesn't correspond to an actual notebook
            Notify.error "EDAMNotFoundException: Invalid parent notebook GUID"
          rescue ArgumentError => e
            Notify.error e.backtrace
          end

          Notify.success("#{parent_notebook.prop(:stack)}/#{parent_notebook.prop(:name)}/#{our_note.title} created")

          self if @entity
        end

        #
        # @since 0.2.0
        def exists?(name)
          return true if !find(name).nil?
          false
        end

        #
        # @since 0.2.0
        def destroy
          @evernote.call(:deleteNote, @entity.guid)
        end

        #
        # @since 0.2.9
        def expunge!
          @evernote.call(:expungeNote, @entity.guid)
        end

        #
        # @since 0.2.0
        def expunge
          deprecation_notice('0.2.9')

          @evernote.call(:expungeNote, @entity.guid)
        end

        #
        # @since 0.2.9
        def move_to(notebook)
          nb = Evertils::Common::Entity::Notebook.new
          target = nb.find(notebook)
          
          @entity.notebookGuid = target.prop(:guid)

          @evernote.call(:updateNote, @entity)
        end

        #
        # @since 0.2.8
        def share
          @evernote.call(:shareNote, @entity.guid)
        end

        #
        # @since 0.2.8
        def unshare
          @evernote.call(:stopSharingNote, @entity.guid)
        end

        #
        # @since 0.2.0
        def find(name)
          @entity = nil

          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = name

          spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          spec.includeTitle = true

          result = @evernote.call(:findNotesMetadata, filter, 0, 1, spec)

          if result.totalNotes > 0
            @entity = result.notes[0]
          end

          self if @entity
        end
        alias_method :find_by_name, :find

        #
        # @since 0.3.0
        def tag(name)
          @entity.tagNames = [name]
          @evernote.call(:updateNote, @entity)
        end

        #
        # @since 0.3.0
        def entity
          @entity
        end

      end
    end
  end
end