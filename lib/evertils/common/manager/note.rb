module Evertils
  module Common
    module Manager
      class Note < Manager::Base

        def create(config)
          note = Evertils::Common::Entity::Note.new
          note.create(config[:name], config[:body], config[:notebook], config[:files], config[:shared], config[:created_on])
        end

        def find(name)

        end

      end
    end
  end
end