require "singleton"

module Evertils
  module Common
    module Manager
      class Note < Manager::Base
        include Singleton

        #
        # @since 0.3.0
        def create(config)
          entity = Evertils::Common::Entity::Note.new
          entity.create(config)
          entity
        end

        #
        # @since 0.3.0
        def find(name, include_note_body = false)
          entity = Evertils::Common::Entity::Note.new
          entity.find(name, include_note_body)
          entity
        end

        #
        # @since 0.3.1
        def find_or_create(name, stack = nil)
          search_result = find(name)

          if !search_result
            note = create(name, stack)
          else
            note = search_result
          end

          note
        end
      end
    end
  end
end