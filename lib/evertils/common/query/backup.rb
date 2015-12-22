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

        attr_accessor :note

        #
        # @since 0.2.8
        def files(*files)
          date = DateTime.now
          note = Entity::Note.new

          note.create("Backup: #{date.to_s}", '', 'Backup', files)
        end

      end
    end
  end
end
