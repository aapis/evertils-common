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

          @entity = nm.create(title: "Backup: #{date}", body: "", parent_notebook: nb, files: files)
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
