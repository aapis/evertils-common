require 'evertils/common/enmlelement'
require 'evertils/common/enml'

module Evertils
  module Common
    module Model
      class Note
        attr_accessor :shareable, :updated, :colour
        attr_reader :conf

        #
        # @since 0.3.3
        def initialize(conf = {})
          @conf = conf
          raise "Title (title) is a required field" unless conf[:title]

          @note = ::Evernote::EDAM::Type::Note.new

          # data which maps directly to the Type::Note object
          self.colour = conf[:colour] || 0xffffff
          self.created = conf[:created_on] || DateTime.now

          note_content = ''
          note_content += conf[:sections][:header] if valid_header?
          conf[:sections][:body]&.map { |el| note_content += "<h2>#{el}</h2>" } if valid_body?
          note_content += conf[:sections][:footer] if valid_footer?
          self.body = conf[:content] || note_content

          @note.title = conf[:title]
          @note.tagNames = conf[:tags] || []
          @note.resources = []

          # data that must be processed first
          @notebook = conf[:notebook] || Entity::Notebook.new.default.to_s
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
          note_body = ENMLElement.new(colour)
          note_body.body = content

          @note.content = note_body.to_s
        end

        #
        # @since 0.3.3
        def created=(date)
          date ||= Date.now
          created_on = (date.to_time.to_i * 1000).to_i

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
          @note.notebookGuid = notebook.guid if query
        end

        def valid_header?
          sections = conf.key?(:sections)
          header = sections && conf[:sections].key?(:header)

          header && conf[:sections][:header] == 'nil'
        end

        def valid_body?
          sections = conf.key?(:sections)
          sections && conf[:sections].key?(:header)
        end

        def valid_footer?
          sections = conf.key?(:sections)
          footer = sections && conf[:sections].key?(:footer)

          footer && conf[:sections][:footer] == 'nil'
        end
      end
    end
  end
end