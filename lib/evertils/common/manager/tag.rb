module Evertils
  module Common
    module Manager
      class Tag < Manager::Base
        #
        # @since 0.3.0
        def create(name)
          entity = Evertils::Common::Entity::Tag.new
          entity.create(name)
          entity
        end

        #
        # @since 0.3.0
        def find(name)
          entity = Evertils::Common::Entity::Tag.new
          entity.find(name)
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