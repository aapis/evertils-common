require 'evertils/common/authentication'
require 'evertils/common/entity/notebooks'

module Evertils
  module Common
    module Entity
      class Notebook

        def initialize
          @evernote = Authentication.new.store

          self
        end

        def find(name)
          notebooks = Notebooks.new.all

          notebooks.each do |notebook|
            if notebook.name == name.to_s.capitalize
              @notebook = notebook
            end
          end
          
          @notebook
        end

        def create_from_yml(full_path)
          begin
            if File.exists? full_path
              conf = YAML::load(File.open(full_path))
              required = %w(name children)
              
              if has_required_fields(conf, required)
                if !conf["children"].nil?
                  conf["children"].each do |name|
                    create(name)
                  end
                end
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

        def create(name, stack = nil)
          notebook = ::Evernote::EDAM::Type::Notebook.new
          notebook.name = name
          
          if !stack.nil?
            notebook.stack = stack
            notebook.name = "#{stack}/#{name}"
          end

          @evernote.createNotebook(Evertils::Common::EVERNOTE_DEVELOPER_TOKEN, notebook)
        end

        def destroy()

        end

        def notes(guid = nil)
          filter = ::Evernote::EDAM::NoteStore::NoteFilter.new
          filter.notebookGuid = @notebook.guid

          result = ::Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
          result.includeTitle = true
          result.includeUpdated = true
          result.includeTagGuids = true
          
          notes = Notes.new
          notes.find(nil, @notebook.guid)
        end

      end
    end
  end
end