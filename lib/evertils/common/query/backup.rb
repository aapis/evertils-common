require 'evertils/common/entity/notebook'
require 'evertils/common/entity/notebooks'
require 'evertils/common/entity/notes'
require 'evertils/common/entity/note'
require 'evertils/common/entity/tag'
require 'evertils/common/entity/tags'
require 'evertils/common/entity/sync'

module Evertils
  module Common
    module Query
      class Backup < Query::Base

        #
        # @since 0.2.8
        def files(*files)
          date = DateTime.now
          nm = Entity::Note.new

          @entity = nm.create("Backup: #{date}", '', 'Backup', files)
        end

        #
        # @since 0.2.9
        def expunge!
          @entity.expunge!
        end

      end
    end
  end
end
