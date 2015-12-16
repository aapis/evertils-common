require 'yaml'
require 'evertils/common/enml'
require 'evertils/common/entity/notebooks'
require 'evertils/common/entity/notebook'
require 'evertils/common/entity/stack'
require 'evertils/common/entity/notes'
require 'evertils/common/entity/note'

module Evertils
  module Common
    class Evernote
      def notebooks
        Notebooks.new.all
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

      # def notebooks_by_stack(stack)
      #   output = {}
      #   notebooks.each do |notebook|
      #     if notebook.stack == stack
      #       #output[notebook.name] = []

      #       filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
      #       filter.notebookGuid = notebook.guid

      #       result = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
      #       result.includeTitle = true
      #       result.includeUpdated = true
      #       result.includeTagGuids = true

      #       notes = @evernote.store.findNotesMetadata(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, filter, 0, 400, result)
      #       output[notebook.name] = notes
      #     end
      #   end
        
      #   output
      # end

      def create_stack_from(full_path)
        nb = Entity::Notebook.new
        nb.create_stack(full_path)
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
        results = Helper::Results.new
        tmpl = date_templates(requested_date)
        template = tmpl[command]
        note = find_note(template)

        # Evernote's search matches things like the following, so we have to get
        # more specific
        #   Daily Log [July 3 - F] == Daily Log [July 10 - F]
        if note.totalNotes > 0
          note.notes.each do |n|
            results.add(n.title != template)
          end
        else
          results.add(true)
        end

        results.should_eval_to(false)
      end

      def create_note(title, body = template_contents, p_notebook_name = nil, file = nil, share_note = false, created_on = nil)
        note = Note.new
        note.create(title, body, p_notebook_name, file, share_note, created_on)
      end

      private

      def has_required_fields(hash, required)
        hash.keys.each do |key|
          required.include? key
        end
      end
    end
  end
end