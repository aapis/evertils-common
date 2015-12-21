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

module Evertils
  module Common
    EVERNOTE_HOST = 'www.evernote.com'
    EVERNOTE_DEVELOPER_TOKEN = ENV['EVERTILS_TOKEN']
  end
end
