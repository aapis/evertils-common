require 'evernote-thrift'
require 'notifaction'
require 'yaml'
require 'mime/types'
require 'date'

require 'evertils/common/enml'
require 'evertils/common/entity'
require 'evertils/common/query'
require 'evertils/common/converter'
require 'evertils/common/manager'
require 'evertils/common/version'

require 'evertils/common/manager/note'
require 'evertils/common/manager/notebook'
require 'evertils/common/manager/sync'
require 'evertils/common/manager/tag'

require 'evertils/common/entity/notebook'
require 'evertils/common/entity/notebooks'
require 'evertils/common/entity/notes'
require 'evertils/common/entity/note'
require 'evertils/common/entity/tag'
require 'evertils/common/entity/tags'
require 'evertils/common/entity/sync'

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

  #
  # @since 0.3.0
  def self.is_test?
    false
  end

  # define Common namespace
  # @since 0.3.0
  module Common
  end

end
