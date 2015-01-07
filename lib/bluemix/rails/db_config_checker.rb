class DbConfigChecker
  attr_reader :yml_file

  def initialize(file_location)
    @yml_file = File.open(file_location).read.split(/\n/)
  end
end
