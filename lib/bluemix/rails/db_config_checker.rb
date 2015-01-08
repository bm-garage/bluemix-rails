class DbConfigChecker
  attr_reader :yml_file
  ELEPHANTSQL_CONFIG = [
      "production:",
      "<% if ENV['VCAP_SERVICES'] %>",
      "<% services = JSON.parse(ENV['VCAP_SERVICES'])",
      "  postgres = services['elephantsql']",
      "  credentials = postgres.first['credentials'] %>",
      "  url: <%= credentials['uri'] %>",
      "<% else %>",
      "  <<: *default",
      "  database: db/production.sqlite3",
      "<% end %>"
  ]

  def initialize(file_location)
    @file_location = file_location
    @yml_file = File.open(file_location).read.split(/\n/)
  end

  def delete_existing_production!
    delete = false

    yml_file.select { |line|

      if delete && !line.start_with?("  ")
        delete = false
      end

      if line.start_with?("production:")
        delete = true
      end

      if !delete
        line
      end
    }
  end

  def add_new_production!
    @yml_file = delete_existing_production! + ELEPHANTSQL_CONFIG
  end

  def update_database_yml
    add_new_production!
    IO.binwrite(@file_location, @yml_file.join("\n"))
  end
end
