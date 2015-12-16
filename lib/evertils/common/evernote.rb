require 'yaml'
require 'evertils/common/enml'
require 'evertils/common/results_helper'
require 'evertils/common/entity/notebooks'
require 'evertils/common/entity/notebook'
require 'evertils/common/entity/notes'
require 'evertils/common/entity/note'

module Evertils
  module Common
    class Evernote

      def notebooks
        Entity::Notebooks.new.all
      end

      def tags
        @evernote.store.listTags(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN)
      end

      def notebook_by_name(name)
        nb = Entity::Notebook.new
        nb.find(name)
      end

      def notes_by_notebook(name)
        nb = Entity::Notebook.new
        nb.find(name)
        nb.notes
      end

      def create_stack_from(full_path)
        nb = Entity::Notebook.new
        nb.create_from_yml(full_path)
      end

      def create_note_from(full_path)
        note = Entity::Note.new
        note.create_from_yml(full_path)
      end

      def create_notebook(name, stack = nil)
        nb = Entity::Notebook.new
        nb.create(name, stack)
      end

      def find_note(title_filter = nil, notebook_filter = nil)
        note = Entity::Note.new
        note.find(title_filter, notebook_filter)
      end

      def note_exists(requested_date = DateTime.now)
        note = Note.new
        note.exists? nil, requested_date
      end

      def create_note(title, body = template_contents, p_notebook_name = nil, file = nil, share_note = false, created_on = nil)
        note = Note.new
        note.create(title, body, p_notebook_name, file, share_note, created_on)
      end

    end
  end
end