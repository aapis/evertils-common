module Evertils
  module Common
    module Model
      class Note
        attr_accessor :resources, :shareable, :updated

        #
        # @since 0.3.3
        def initialize(conf = {})
          raise "Title (title) is a required field" unless conf[:title]
          raise "Body (body) is a required field" unless conf[:body]

          @note = ::Evernote::EDAM::Type::Note.new

          # data which maps directly to the Type::Note object
          @note.title = conf[:title]
          # @note.content = conf[:body]
          self.body = conf[:body]
          @note.notebookGuid = conf[:parent_notebook] ||= nil
          @note.tagNames = conf[:tags] ||= []
          @note.created = conf[:created_on] ||= nil
          @note.resources = []

          # data that must be processed first
          @resources = conf[:file] ||= []
          @shareable = conf[:share_note] ||= false
          @updated = conf[:updated_on] ||= nil
        end

        def add_resources
          if @resources.is_a? Array
            @resources.each do |f|
              media_resource = ENML.new(f)
              content.concat(media_resource.embeddable_element)
              @note.resources << media_resource.element
            end
          else
            media_resource = ENML.new(@resources)
            content.concat(media_resource.embeddable_element)
            @note.resources << media_resource.element
          end
        end

        # Accessor for the title property
        # @since 0.3.3
        def title
          @note.title
        end

        # Accessor for the body/content property
        # @since 0.3.3
        def body
          @note.content
        end
        alias content body

        #
        # @since 0.3.3
        def body=(content)
          puts content
          note_body = ENMLElement.new
          note_body.body = content

          @note.content = note_body
        end

        # Accessor for the notebook property
        # @since 0.3.3
        def notebook
          @note.notebookGuid
        end

        # Accessor for the tagNames property
        # @since 0.3.3
        def tags
          @note.tagNames
        end

        # Accessor for the created_on property
        # @since 0.3.3
        def created
          @note.created
        end

        # The whole note
        # @since 0.3.3
        def prepare
          @note
        end
      end
    end
  end
end