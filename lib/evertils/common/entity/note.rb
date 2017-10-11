module Evertils
  module Common
    module Entity
      class Note < Entity::Base
        #
        # @since 0.2.0
        def create_from_yml(full_path)
          raise "File not found: #{full_path}" unless File.exist? full_path

          begin
            conf = YAML::load(File.open(full_path))
            required = %w(title body)

            if has_required_fields(conf, required)
              create(conf['title'], conf['body'], conf['parent'])
            else
              raise ArgumentError, 'Configuration file is missing some required fields'
            end
          rescue ArgumentError => e
            puts e.message
          end
        end

        #
        # @since 0.2.0
        def create(conf = {})
          note = Evertils::Common::Model::Note.new(conf)
          @entity = @evernote.call(:createNote, note.entity)

          return false unless @entity

          share if note.shareable

          # TODO: get metadata back so we can print stack/notebook info
          # Notify.success("#{note.notebook.prop(:stack)}/#{note.notebook.prop(:name)}/#{note.entity.title} created")
          Notify.success("#{note.entity.title} created")
          self
        end

        #
        # @since 0.2.0
        def exists?
          !@entity.nil?
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
          deprecation_notice('0.2.9', 'Replaced with expunge! to better follow Ruby standards for method names.  Will be removed in 0.3.5')

          @evernote.call(:expungeNote, @entity.guid)
        end

        #
        # @since 0.2.9
        def move_to(notebook)
          nb = Evertils::Common::Manager::Notebook.instance
          target = nb.find(notebook)

          raise "Notebook not found: #{notebook}" if target.entity.nil?

          @entity.notebookGuid = target.to_s

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
          filter.words = "intitle:#{name}"

          spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          spec.includeTitle = true
          spec.includeTagGuids = true

          result = @evernote.call(:findNotesMetadata, filter, 0, 10, spec)

          @entity = result.notes.detect { |note| note.title == name }

          self if @entity
        end
        alias_method :find_by_name, :find

        #
        # @since 0.2.0
        def find_with_contents(name)
          find_result = find(name)

          raise "Note not found: #{name}" if find_result.entity.nil?

          @entity = find_result.entity

          spec = ::Evernote::EDAM::NoteStore::NoteResultSpec.new
          spec.includeResourcesData = true
          spec.includeContent = true

          result = @evernote.call(:getNoteWithResultSpec, @entity.guid, spec)

          @entity = result

          self if @entity
        end

        #
        # @since 0.3.0
        def tag(*guids)
          guids = guids.map(&:to_s)
          existing_tags = @entity.tagGuids
          @entity.tagGuids = [] unless existing_tags.is_a?(Array)
          @entity.tagGuids.concat(guids)

          @evernote.call(:updateNote, @entity)
        end

        #
        # @since 0.3.3
        def attach_file(file)
          if file.is_a? Array
            file.each do |f|
              media_resource = ENML.new(f)
              body.concat(media_resource.embeddable_element)
              @entity.resources << media_resource.element
            end
          else
            media_resource = ENML.new(file)
            body.concat(media_resource.embeddable_element)
            @entity.resources << media_resource.element
          end

          @evernote.call(:updateNote, @entity)
        end
      end
    end
  end
end