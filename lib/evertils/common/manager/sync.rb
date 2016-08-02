require "singleton"

module Evertils
  module Common
    module Manager
      class Sync < Manager::Base
        include Singleton

        #
        # @since 0.3.0
        def state
          entity = Evertils::Common::Entity::Sync.new
          entity.state
        end
      end
    end
  end
end