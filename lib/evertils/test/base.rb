require 'minitest/autorun'

module Evertils
  module Test
    class Base < Minitest::Test

      # Run before all tests (check the Rakefile for specifics)
      # @since 0.3.0
      def self.before
        inst = Base.new(nil)

        Notify.spit "Preparing to execute tests"
        inst.setup
        inst.clean

        Notify.spit "Seeding test data"
        inst.seed
      end

      # Run after all tests (check the Rakefile for specifics)
      # @since 0.3.0
      def self.after
        inst = Base.new(nil)

        Notify.spit "Performing teardown tasks"
        inst.setup

        Notify.spit "Deleting test data"
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

        return unless File.exist? full_path

        begin
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
        rescue ArgumentError => e
          puts e.message
        end
      end

      # Remove all seeded data after all tests have run
      # @since 0.3.0
      def clean
        nb = Evertils::Common::Entity::Notebooks.new
        nbm = Evertils::Common::Manager::Notebook.new
        notes = Evertils::Common::Entity::Notes.new
        auth = Evertils::Common::Authentication.instance
        tm = Evertils::Common::Entity::Tags.new

        tags = tm.all

        if tags.size > 0
          puts "Deleting #{tags.size} tags..."
          tags.each do |tag|
            auth.call(:expungeTag, tag.guid)
          end
        end

        notebooks = nb.all

        if notebooks.size  > 0
          puts "Deleting #{notebooks.size - 1} notebooks..." # -1 for default notebook
          default = nbm.find_or_create('Default')

          notebooks.each do |nb|
            next if nb.guid == default.to_s
            auth.call(:expungeNotebook, nb.guid)
          end
        end

        notes = notes.all('testing')

        if notes.size > 0
          puts "Deleting #{notes.size} notes..."
          notes.each do |note|
            auth.call(:expungeNote, note.guid)
          end
        end

        puts "Sample data deleted"
      end

    end
  end
end