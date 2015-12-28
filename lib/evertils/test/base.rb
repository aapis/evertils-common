require 'minitest/autorun'

module Evertils
  module Test
    class Base < Minitest::Test

      #
      # @since 0.3.0
      def setup
        seed if !@first_run
        @first_run = false

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
                    #note.create(name, "Body for #{name.downcase}", ch_nb, nil, false, options['created_on'])
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
        rescue => e
          puts e.inspect
        end
        
        exit

      end

      # Remove all seeded data after all tests have run
      # @since 0.3.0
      def clean

      end

    end
  end
end