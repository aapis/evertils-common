require 'evertils/test'

class ConvertersTest < Evertils::Test::Base

  def setup
    super

    @yml_conv_entity = Evertils::Common::Converter::YamlToEnml.new
  end

  # TODO: Commented out temporarily
  # @since 0.2.9
  # def test_yaml_to_enml_from_file
  #   assert @yml_conv_entity.from_file('/Users/ryanpriebe/test.yml'), 'Could not convert from YAML file'
  # end

  #
  # @since 0.2.9
  def test_yaml_to_enml_from_string
    assert @yml_conv_entity.from_string('name: HF2
children:
  - Accounts
  - Agendas
  - Design Documents
  - Interviews/HR
  - Notes + Documentation'), 'Could not convert from YAML string'
  end

end