require 'evernote-thrift'
require 'notifaction'
require 'yaml'
require 'mime/types'
require 'date'

require 'evertils/common/enml'
require 'evertils/common/entity'
require 'evertils/common/query'
require 'evertils/common/converter'
require 'evertils/common/version'
require 'evertils/common/query/backup'
require 'evertils/common/query/simple'
require 'evertils/common/query/time'
require 'evertils/common/converter/yaml_to_enml'

module Evertils

  #
  # @since 0.3.0
  def self.token
    ENV['EVERTILS_TOKEN']
  end

  #
  # @since 0.3.0
  def self.host
    'www.evernote.com'
  end

  # define Common namespace
  # @since 0.3.0
  module Common
  end

end
