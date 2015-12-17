require 'yaml'
require 'evertils/common/enml'
require 'evertils/common/entity/notebook'
require 'evertils/common/entity/notebooks'
require 'evertils/common/entity/notes'
require 'evertils/common/entity/note'
require 'evertils/common/entity/tag'
require 'evertils/common/entity/tags'

module Evertils
  module Common
    class SimpleQueries

      def notebooks
        Entity::Notebooks.new.all
      end

      def tags
        Entity::Tags.new.all
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
        stack = Entity::Stack.new
        stack.create_from_yml(full_path)
      end

      def create_note_from(full_path)
        note = Entity::Note.new
        note.create_from_yml(full_path)
      end

      def create_notebooks_from(full_path)
        nb = Entity::Notebooks.new
        nb.create_from_yml(full_path)
      end

      def create_notebook(name, stack = nil)
        nb = Entity::Notebook.new
        nb.create(name, stack)
      end

      def find_note(title_filter = nil, notebook_filter = nil)
        note = Entity::Note.new
        note.find(title_filter, notebook_filter)
      end

      def note_exists(name)
        note = Entity::Note.new
        note.exists? name
      end

      def create_note(title, body = template_contents, p_notebook_name = nil, file = nil, share_note = false, created_on = nil)
        note = Entity::Note.new
        note.create(title, body, p_notebook_name, file, share_note, created_on)
      end

    end
  end
end