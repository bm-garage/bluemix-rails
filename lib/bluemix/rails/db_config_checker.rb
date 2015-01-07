class DbConfigChecker
  attr_reader :yml_file

  def initialize(file_location)
    @yml_file = File.open(file_location).read.split(/\n/)
  end

  def delete_existing_production!
    delete = false

    yml_file.select {|line|

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
end
