require 'evertils/common/entity/notebook'
require 'evertils/common/entity/notebooks'
require 'evertils/common/entity/notes'
require 'evertils/common/entity/note'
require 'evertils/common/entity/sync'

module Evertils
  module Common
    module Query
      class Time

        #
        # @since 0.2.8
        def notes_created_in_range(start, finish)

        end

        #
        # @since 0.2.8
        def notes_updated_in_range(start, finish)

        end

        #
        # @since 0.2.8
        def notebooks_created_in_range(start, finish)

        end

        #
        # @since 0.2.8
        def notebooks_updated_in_range(start, finish)

        end

        #
        # @since 0.2.8
        def last_sync
          entity = Evertils::Common::Entity::Sync.new
          puts entity.inspect
        end

      end
    end
  end
end
