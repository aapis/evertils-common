require 'minitest/autorun'
require 'evertils/common'

class ConvertersTest < Minitest::Test

  def test_yaml_to_enml_from_file
    conv = Evertils::Common::Converter::YamlToEnml.new

    conv.from_file('/Users/ryanpriebe/test.yml')
  end

end