require 'evernote-thrift'
require 'notifaction'
require 'yaml'
require 'evertils/common/enml'
require 'evertils/common/entity'
require 'evertils/common/version'
require 'evertils/common/queries/simple'
require 'evertils/common/queries/time'

module Evertils
  module Common
    EVERNOTE_HOST = 'www.evernote.com'
    EVERNOTE_DEVELOPER_TOKEN = ENV['EVERTILS_TOKEN']
  end
end
