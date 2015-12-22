require 'evertils/common/entity/notebook'
require 'evertils/common/entity/notebooks'
require 'evertils/common/entity/notes'
require 'evertils/common/entity/note'

module Evertils
  module Common
    module Query
      class Time < Query::Base

        #
        # @since 0.2.8
        def notes_created_in_range(start, finish = nil)
          finish = DateTime.now if !finish
          note_manager = Evertils::Common::Entity::Note.new

          note_manager.find_by_date_range(start, finish)
        end

        #
        # @since 0.2.8
        def notes_updated_in_range(start, finish = nil)
          finish = DateTime.now if !finish

        end

        #
        # @since 0.2.8
        def notes_created_on(date = DateTime.now)
          note_manager = Evertils::Common::Entity::Note.new

          # start should be used for both start and end here
          note_manager.find_by_date(date)
        end

        #
        # @since 0.2.8
        def notebooks_created_in_range(start, finish = nil)
          finish = DateTime.now if !finish

        end

        #
        # @since 0.2.8
        def notebooks_updated_in_range(start, finish = nil)
          finish = DateTime.now if !finish

        end

      end
    end
  end
end
