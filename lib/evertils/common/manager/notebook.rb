module Evertils
  module Common
    module Manager
      class Notebook < Manager::Base

        #
        # @since 0.3.0
        def create(name, stack = nil)
          entity = Evertils::Common::Entity::Notebook.new
          entity.create(name, stack)
        end

        #
        # @since 0.3.0
        def find(name)
          entity = Evertils::Common::Entity::Notebook.new
          entity.find(name)
        end

      end
    end
  end
end