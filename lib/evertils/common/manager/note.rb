module Evertils
  module Common
    module Manager
      class Note < Manager::Base

        #
        # @since 0.3.0
        def create(config)
          entity = Evertils::Common::Entity::Note.new
          entity.create(config[:name], config[:body], config[:notebook], config[:files], config[:shared], config[:created_on])
        end

        #
        # @since 0.3.0
        def find(name)
          entity = Evertils::Common::Entity::Note.new
          entity.find(name)
        end

      end
    end
  end
end