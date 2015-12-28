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
          backup_notebook_name = 'Backup'
          nm = Entity::Note.new
          
          # create the backup notebook if it does not exist
          nb_entity = Entity::Notebook.new
          nb = nb_entity.find(backup_notebook_name)

          if nb_entity.find(backup_notebook_name).nil?
            nb = nb_entity.create(backup_notebook_name)
          end

          @entity = nm.create("Backup: #{date}", "", nb, files)
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
