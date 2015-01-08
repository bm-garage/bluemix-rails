class EnvChecker
  attr_accessor :vcap

  def initialize(app_name)
    @vcap = `cf env #{app_name}`
  end

  def elephant_sql?
    vcap.key?("elephantsql")
  end

end
