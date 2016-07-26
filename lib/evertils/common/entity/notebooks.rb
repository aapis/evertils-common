module Evertils
  module Common
    module Entity
      class Notebooks < Entity::Base
        #
        # @since 0.1.0
        def all
          @evernote.call(:listNotebooks)
        end

        #
        # @since 0.1.0
        def create_from_yml(full_path)
          raise "File not found: #{full_path}" unless File.exist? full_path

          begin
            nb = Notebook.new

            conf = YAML::load(File.open(full_path))
            required = %w(notebooks)

            if has_required_fields(conf, required)
              if !conf["notebooks"].nil?
                conf["notebooks"].each do |name|
                  nb.create(name)
                end
              end
            else
              raise ArgumentError, 'Configuration file is missing some required fields'
            end
          rescue ArgumentError => e
            puts e.message
          rescue Evernote::EDAM::Error::EDAMUserException => e
            puts e.message
          end
        end

        #
        # @since 0.3.2
        def find_by_date_range(start, finish = DateTime.now, period = :created)
          pool = all
          # method is serviceCreated/serviceUpdated
          period = "service#{period.to_s.capitalize_first_char}"

          pool.select do |book|
            f = finish.to_time.to_i
            s = start.to_time.to_i
            b = book_date(book, period).to_time.to_i

            b <= f && b >= s
          end
        end

        private

        #
        # @since 0.3.2
        def book_date(book, period)
          DateTime.strptime(book.send(period).to_s[0...-3], '%s')
        end
      end
    end
  end
end