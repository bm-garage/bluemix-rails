require 'spec_helper'

describe EnvChecker do

  it 'should retrieve postgres info from env hash' do
    checker = EnvChecker.new("testapp")
    checker.vcap = {
        "elephantsql" => [
            {
                "name" => "elephant",
                "label" => "elephantsql",
                "plan" => "turtle",
                "credentials" => {
                    "uri" => "postgres://sfsvfblj:Bzxso7A1_QXTjaFVayHqyDOdN1S4F45h@jumbo.db.elephantsql.com:5432/sfsvfblj",
                    "max_conns" => "5"
                }
            }
        ]
    }
    expect(checker.elephant_sql?).to eq(true)
  end
end
