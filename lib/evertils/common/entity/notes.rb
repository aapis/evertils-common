module Evertils
  module Common
    module Entity
      class Notes < Entity::Base

        #
        # @since 0.3.2
        def all(keyword)
          find_all(keyword, nil, 1000)
        end

        #
        # @since 0.2.0
        def find_all(title, notebook = nil, limit = 300)
          filters = find_filters(title, notebook)

          response = @evernote.call(:findNotesMetadata, filters, nil, limit, find_spec)
          response.notes
        end
        alias_method :find, :find_all

        #
        # @since 0.2.0
        def find_one(title, notebook = nil)
          filters = find_filters(title, notebook)

          response = @evernote.call(:findNotesMetadata, filters, nil, 10, find_spec)

          notes = response.notes.detect { |note| note.title == title }
          notes
        end

        #
        # @since 0.2.0
        def find_by_tag(tag_name)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "tag:#{tag_name}"

          spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          spec.includeTitle = true

          response = @evernote.call(:findNotesMetadata, filter, nil, 300, spec)
          response.notes
        end

        #
        # @since 0.2.9
        def find_by_date_range(start, finish = DateTime.now, period = :created)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "#{period}:year-#{year_diff(start.year)}"
          filter.order = 1

          spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          spec.includeTitle = true
          spec.includeUpdated = true
          spec.includeCreated = true

          pool = @evernote.call(:findNotesMetadata, filter, 0, 300, spec)

          pool.notes.select do |note|
            f = finish.to_time.to_i
            s = start.to_time.to_i
            n = note_date(note, period).to_time.to_i

            n <= f && n >= s
          end
        end

        #
        # @since 0.2.9
        def find_by_date(date, period = :created)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "#{period}:year-#{year_diff(date.year)}"
          filter.order = 1

          spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          spec.includeTitle = true
          spec.includeUpdated = true
          spec.includeCreated = true

          pool = @evernote.call(:findNotesMetadata, filter, 0, 300, spec)
          
          pool.notes.select do |note|
            n = note_date(note, period)

            n.strftime('%m-%d-%Y') == date.strftime('%m-%d-%Y')
          end
        end

        private

        #
        # @since 0.2.9
        def year_diff(start_year)
          curr_year = DateTime.now.year
          diff = curr_year - start_year

          return 1 if diff == 0 || start_year > curr_year

          diff
        end

        #
        # @since 0.2.0
        def note_date(note, period)
          DateTime.strptime(note.send(period).to_s[0...-3], '%s')
        end

        #
        # @since 0.3.2
        def find_filters(title, notebook)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.words = "intitle:#{title}" if title
          filter.notebookGuid = notebook if notebook
          filter
        end

        #
        # @since 0.3.2
        def find_spec
          spec = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          spec.includeTitle = true
          spec
        end

      end
    end
  end
end