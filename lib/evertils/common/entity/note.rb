module Evertils
  module Common
    module Entity
      class Note < Entity::Base

        def create_from_yml(full_path)
          begin
            if File.exists? full_path
              conf = YAML::load(File.open(full_path))
              required = %w(title body)

              if has_required_fields(conf, required)
                create(conf['title'], conf['body'], conf['parent'])
              else
                raise ArgumentError, 'Configuration file is missing some required fields'
              end
            else
              raise ArgumentError, "File not found: #{full_path}"
            end
          rescue ArgumentError => e
            puts e.message
          end
        end

        def create(title, body, p_notebook_name = nil, file = nil, share_note = false, created_on = nil)
          # final output
          output = {}

          # Create note object
          our_note = ::Evernote::EDAM::Type::Note.new
          our_note.resources = []
          our_note.tagNames = []

          # a file was requested, lets prepare it for storage
          if file
            if file.is_a? Array
              file.each do |f|
                media_resource = ENML.new(f)
                body.concat(media_resource.embeddable_element)
                our_note.resources << media_resource.element
              end
            else
              media_resource = ENML.new(file)
              body.concat(media_resource.embeddable_element)
              our_note.resources << media_resource.element
            end
          end

          # only join when required
          body = body.join if body.is_a? Array

          n_body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
          n_body += "<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"
          n_body += "<en-note>#{body}</en-note>"
         
          # setup note properties
          our_note.title = title
          our_note.content = n_body
          our_note.created = created_on if !created_on.nil?

          if !p_notebook_name.is_a? ::Evernote::EDAM::Type::Notebook
            nb = Entity::Notebook.new
            parent_notebook = nb.find(p_notebook_name)
            parent_notebook = @evernote.call(:getDefaultNotebook) if parent_notebook.nil?
          end
          
          # parent_notebook is optional; if omitted, default notebook is used
          our_note.notebookGuid = parent_notebook.guid

          # Attempt to create note in Evernote account
          begin
            output[:note] = @evernote.call(:createNote, our_note)
            
            if share_note
              shareKey = @evernote.call(:shareNote, output[:note].guid)
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

          Notify.success("#{parent_notebook.stack}/#{parent_notebook.name}/#{our_note.title} created")

          output
        end

        def exists?(name)
          # notes = Notes.new
          # notes.find_all(name).size > 0
          return true if find(name).guid
          false
        end

        def destroy(name)
          note = find(name).guid

          @evernote.call(:deleteNote, note)
        end

        def expunge(name)
          note = find(name).guid

          @evernote.call(:expungeNote, note)
        end

        #
        # @since 0.2.8
        def share(name)
          note = find(name).guid

          @evernote.call(:shareNote, note)
        end

        #
        # @since 0.2.8
        def unshare(name)
          note = find(name).guid

          @evernote.call(:stopSharingNote, note)
        end

        def find(name)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = name

          spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          spec.includeTitle = true

          result = @evernote.call(:findNotesMetadata, filter, 0, 1, spec)

          if result.totalNotes > 0
            return result.notes[0]
          end
        end
        alias_method :find_by_name, :find
        
        def find_by_date_range(start, finish = DateTime.now, period = :created)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "#{period}:year-#{year_diff(start.year)}"
          filter.order = 1

          spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          spec.includeTitle = true
          spec.includeUpdated = true
          spec.includeCreated = true

          pool = @evernote.call(:findNotesMetadata, filter, 0, 300, spec)
          notes_by_date = []

          pool.notes.each do |note|
            note_datetime = DateTime.strptime(note.send(period).to_s[0...-3], '%s')

            notes_by_date << note if note_datetime.strftime('%m-%d-%Y') < finish.strftime('%m-%d-%Y') && note_datetime.strftime('%m-%d-%Y') > start.strftime('%m-%d-%Y')
          end

          notes_by_date
        end

        def find_by_date(date, period = :created)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "#{period}:year-#{year_diff(date.year)}"
          filter.order = 1

          spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          spec.includeTitle = true
          spec.includeUpdated = true
          spec.includeCreated = true

          pool = @evernote.call(:findNotesMetadata, filter, 0, 300, spec)
          notes_by_date = []
          
          pool.notes.each do |note|
            note_datetime = DateTime.strptime(note.send(period).to_s[0...-3], '%s')

            notes_by_date << note if note_datetime.strftime('%m-%d-%Y') == date.strftime('%m-%d-%Y')
          end

          notes_by_date
        end

        private

        def year_diff(start_year)
          curr_year = DateTime.now.year
          diff = curr_year - start_year

          return 1 if diff == 0 || start_year > curr_year

          diff
        end

      end
    end
  end
end