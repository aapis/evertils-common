require 'evertils/common/enmlelement'
require 'evertils/common/enml'

module Evertils
  module Common
    module Model
      class Note
        attr_accessor :shareable, :updated

        #
        # @since 0.3.3
        def initialize(conf = {})
          raise "Title (title) is a required field" unless conf[:title]
          raise "Body (body) is a required field" unless conf[:body]

          @note = ::Evernote::EDAM::Type::Note.new

          # data which maps directly to the Type::Note object
          self.body = conf[:body]
          self.created = conf[:created_on] || DateTime.now

          @note.title = conf[:title]
          @note.tagNames = conf[:tags] || []
          @note.resources = []

          # data that must be processed first
          @notebook = conf[:parent_notebook] || Entity::Notebook.new.default.to_s
          @resources = conf[:file] || []
          @shareable = conf[:share_note] || false
          @updated = conf[:updated_on] || nil

          attach_resources
          attach_notebook
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
        def entity
          @note
        end

        protected

        # Body content must be valid ENML so we create that here
        # @since 0.3.3
        def body=(content)
          note_body = ENMLElement.new
          note_body.body = content

          @note.content = note_body.to_s
        end

        #
        # @since 0.3.3
        def created=(date)
          date = DateTime.now unless date
          created_on = (date.to_time.to_i.to_s + "000").to_i

          @note.created = created_on
        end

        private

        def attach_resources
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

        def attach_notebook
          nb = Manager::Notebook.instance
          query = nb.find(@notebook.to_s)
          notebook = query.entity
          @note.notebookGuid = notebook if query
        end
      end
    end
  end
end