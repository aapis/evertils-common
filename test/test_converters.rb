require 'minitest/autorun'
require 'evertils/common'

class ConvertersTest < Minitest::Test

  #
  # @since 0.2.9
  def test_yaml_to_enml_from_file
    conv = Evertils::Common::Converter::YamlToEnml.new

    assert conv.from_file('/Users/ryanpriebe/test.yml'), 'Could not convert from YAML file'
  end

  #
  # @since 0.2.9
  def test_yaml_to_enml_from_string
    conv = Evertils::Common::Converter::YamlToEnml.new

    assert conv.from_string('name: HF2
children:
  - Accounts
  - Agendas
  - Design Documents
  - Interviews/HR
  - Notes + Documentation'), 'Could not convert from YAML string'
  end

end