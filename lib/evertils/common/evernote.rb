require 'evertils/common/authentication'

module Evertils
  module Common
    class Evernote
      def initialize
        @evernote = Evertils::Common::Authentication.new
      end

      def notebooks
        @evernote.store.listNotebooks(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN)
      end

      def tags
        @evernote.store.listTags(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN)
      end

      def notebook_by_name(name = command)
        output = {}
        notebooks.each do |notebook|
          if notebook.name == name.to_s.capitalize
            output = notebook
          end
        end
        
        output
      end

      def notes_by_notebook(name)
        output = {}
        notebooks.each do |notebook|
          if notebook.name.to_s == name.capitalize.to_s
            filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
            filter.notebookGuid = notebook.guid

            result = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
            result.includeTitle = true
            result.includeUpdated = true
            result.includeTagGuids = true

            #output = @evernote.store.findNotesMetadata(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, filter, 0, 400, result)
            notes(nil, notebook.guid).notes.each do |note|
              output[note.guid] = @evernote.store.getNoteContent(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, note.guid)
            end
          end
        end

        output
      end

      def notebooks_by_stack(stack)
        output = {}
        notebooks.each do |notebook|
          if notebook.stack == stack
            #output[notebook.name] = []

            filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
            filter.notebookGuid = notebook.guid

            result = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
            result.includeTitle = true
            result.includeUpdated = true
            result.includeTagGuids = true

            notes = @evernote.store.findNotesMetadata(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, filter, 0, 400, result)
            output[notebook.name] = notes
          end
        end
        
        output
      end

      def find_note(title_filter = nil, notebook_filter = nil)
        filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
        filter.words = "intitle:#{title_filter}" if title_filter
        filter.notebookGuid = notebook_filter if notebook_filter

        @evernote.store.findNotes(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, filter, nil, 1)
      end

      def notes(title_filter = nil, notebook_filter = nil)
        filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
        filter.words = "intitle:#{title_filter}" if title_filter
        filter.notebookGuid = notebook_filter if notebook_filter

        @evernote.store.findNotes(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, filter, nil, 300)
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

      def create_note(title = command.capitalize, body = template_contents, p_notebook_name = nil, file = nil, share_note = false, created_on = nil)
        # final output
        output = {}

        # Create note object
        our_note = ::Evernote::EDAM::Type::Note.new
        our_note.resources = []
        our_note.tagNames = []

        # only join when required
        if body.is_a? Array
          body = body.join
        end

        # a file was requested, lets prepare it for storage
        if !file.nil?
          media_resource = EvernoteENML.new(file)
          body.concat(media_resource.embeddable_element)
          our_note.resources << media_resource.element
        end

        n_body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
        n_body += "<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"
        n_body += "<en-note>#{body}</en-note>"
       
        # setup note properties
        our_note.title = title
        our_note.content = n_body
        our_note.created = created_on if !created_on.nil?

        if p_notebook_name.nil?
          parent_notebook = notebook_by_name
        else
          parent_notebook = notebook_by_name(p_notebook_name)
        end
        
        ## parent_notebook is optional; if omitted, default notebook is used
        if parent_notebook.is_a? ::Evernote::EDAM::Type::Notebook
          our_note.notebookGuid = parent_notebook.guid
        end

        ## Attempt to create note in Evernote account
        begin
          output[:note] = @evernote.store.createNote(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, our_note)
          
          if share_note
            shareKey = @evernote.store.shareNote(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, output[:note].guid)
            output[:share_url] = "https://#{Evertils::Common::EVERNOTE_HOST}/shard/#{@model.shardId}/sh/#{output[:note].guid}/#{shareKey}"
          end
        rescue ::Evernote::EDAM::Error::EDAMUserException => edue
          ## Something was wrong with the note data
          ## See EDAMErrorCode enumeration for error code explanation
          ## http://dev.evernote.com/documentation/reference/Errors.html#Enum_EDAMErrorCode
          Notify.error "EDAMUserException: #{edue}\nCode #{edue.errorCode}: #{edue.parameter}"
        rescue ::Evernote::EDAM::Error::EDAMNotFoundException => ednfe
          ## Parent Notebook GUID doesn't correspond to an actual notebook
          Notify.error "EDAMNotFoundException: Invalid parent notebook GUID"
        end

        # A parent notebook object exists, otherwise it was saved to the default
        # notebook
        if parent_notebook.is_a? ::Evernote::EDAM::Type::Notebook
          Notify.success("#{parent_notebook.stack}/#{parent_notebook.name}/#{our_note.title} created")
        else
          Notify.success("DEFAULT_NOTEBOOK/#{our_note.title} created")
        end

        output
      end
    end
  end
end