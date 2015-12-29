require 'minitest/autorun'

module Evertils
  module Test
    class Base < Minitest::Test

      # Run before all tests (check the Rakefile for specifics)
      # @since 0.3.0
      def self.before
        puts "Seeding test data"
        inst = Base.new(nil)
        inst.seed
      end

      # Run after all tests (check the Rakefile for specifics)
      # @since 0.3.0
      def self.after
        puts "Deleting test data"
        inst = Base.new(nil)
        inst.clean
      end

      #
      # @since 0.3.0
      def setup
        entity = Evertils::Common::Entity::Sync.new
        @evernote = entity.evernote

        if !entity.state.is_a?(Evernote::EDAM::NoteStore::SyncState)
          puts 'Could not determine connection to the Evernote API, exiting'
          exit(1)
        end
      end

      #
      # @since 0.3.0
      def seed
        full_path = File.join(File.dirname(__FILE__), 'seed/all.yml')
        
        begin
          if File.exist? full_path
            conf = YAML::load(File.open(full_path))
            
            nb = Evertils::Common::Entity::Notebook.new(@evernote)
            note = Evertils::Common::Entity::Note.new(@evernote)

            conf.each do |stack_name|
              stack_name.last.each_pair do |key, arr|
                puts "Creating: #{stack_name.first}/#{key}..."
                ch_nb = nb.create(key, stack_name.first)

                arr.each do |child_note|
                  child_note.each_pair do |name, options|
                    puts "Creating: #{stack_name.first}/#{key}/#{name}.note..."
                    parsed = DateTime.parse(options['created_on'])

                    created_on = (parsed.to_time.to_i.to_s + "000").to_i
                    note.create(name, "Body for test note", ch_nb, nil, false, created_on)
                  end
                end
              end
            end

            puts "Sample data seeded"
          else
            raise ArgumentError, "File not found: #{full_path}"
          end
        rescue ArgumentError => e
          puts e.message
        end
      end

      # Remove all seeded data after all tests have run
      # @since 0.3.0
      def clean
        full_path = File.join(File.dirname(__FILE__), 'seed/all.yml')
        
        begin
          if File.exist? full_path
            conf = YAML::load(File.open(full_path))
            
            nb = Evertils::Common::Entity::Notebook.new(@evernote)
            nm = Evertils::Common::Entity::Note.new(@evernote)

            conf.each do |stack_name|
              stack_name.last.each_pair do |key, arr|
                puts "Deleting: #{stack_name.first}/#{key}..."
                ch_nb = nb.find(key)
                ch_nb.expunge! if ch_nb

                arr.each do |child_note|
                  child_note.each_pair do |name, options|
                    puts "Deleting: #{stack_name.first}/#{key}/#{name}.note..."
                    note = nm.find(name)
                    note.expunge! if note
                  end
                end
              end
            end

            puts "Sample data seeded"
          else
            raise ArgumentError, "File not found: #{full_path}"
          end
        rescue ArgumentError => e
          puts e.message
        end
      end

    end
  end
end