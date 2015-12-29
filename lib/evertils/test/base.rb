require 'minitest/autorun'

module Evertils
  module Test
    class Base < Minitest::Test

      # Run before all tests (check the Rakefile for specifics)
      # @since 0.3.0
      def self.before
        puts "Seeding test data"
        inst = Base.new(nil)
        inst.setup
        inst.seed
      end

      # Run after all tests (check the Rakefile for specifics)
      # @since 0.3.0
      def self.after
        puts "Deleting test data"
        inst = Base.new(nil)
        inst.setup
        inst.clean
      end

      #
      # @since 0.3.0
      def setup
        entity = Evertils::Common::Manager::Sync.new

        @@test_time = Time.now.to_i

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
            
            nb = Evertils::Common::Entity::Notebook.new
            note = Evertils::Common::Entity::Note.new

            conf.each do |stack_name|
              stack_name.last.each_pair do |key, arr|
                puts "Creating: #{stack_name.first}/#{key}-#{@@test_time}..."
                ch_nb = nb.create("#{key}-#{@@test_time}", stack_name.first)

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
            
            nb = Evertils::Common::Entity::Notebooks.new
            nbm = Evertils::Common::Manager::Notebook.new
            auth = Evertils::Common::Authentication.instance
            tm = Evertils::Common::Entity::Tags.new

            puts "Deleting all tags..."
            tags = tm.all
            tags.each do |tag|
              auth.call(:expungeTag, tag.guid)
            end

            puts "Deleting all notebooks..."
            notebooks = nb.all
            default = nbm.create('Default')
            notebooks.each do |nb|
              next if nb.guid == default.prop(:guid)
              auth.call(:expungeNotebook, nb.guid)
            end

            puts "Sample data deleted"
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