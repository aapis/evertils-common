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
        def find(name)
          entity = Evertils::Common::Entity::Note.new
          entity.find(name)
          entity
        end

        #
        # @since 0.3.13
        def find_with(conf)
          entity = Evertils::Common::Entity::Note.new
          entity.find_with(conf)
          entity
        end

        #
        # @since 0.3.0
        def find_with_contents(name)
          entity = Evertils::Common::Entity::Note.new
          entity.find_with_contents(name)
          entity
        end

        #
        # @since 0.3.18
        def find_note_contents_using_grammar(grammar)
          entity = Evertils::Common::Entity::Note.new
          entity.find_note_contents_using_grammar(grammar)
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