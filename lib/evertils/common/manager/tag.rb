module Evertils
  module Common
    module Manager
      class Tag < Manager::Base

        #
        # @since 0.3.0
        def create(name)
          entity = Evertils::Common::Entity::Tag.new
          entity.create(name)
        end

        #
        # @since 0.3.0
        def find(name)
          entity = Evertils::Common::Entity::Tag.new
          entity.find(name)
        end

      end
    end
  end
end