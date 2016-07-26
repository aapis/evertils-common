module Evertils
  module Common
    module Manager
      class Notebook < Manager::Base
        #
        # @since 0.3.0
        def create(name, stack = nil)
          entity = Evertils::Common::Entity::Notebook.new
          entity.create(name, stack)
          entity
        end

        #
        # @since 0.3.0
        def find(name)
          entity = Evertils::Common::Entity::Notebook.new
          entity.find(name)
          entity
        end

        #
        # @since 0.3.0
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