require 'evernote-thrift'
require 'notifaction'
require 'yaml'
require 'evertils/common/enml'
require 'evertils/common/version'
require 'evertils/common/queries/simple'

module Evertils
  module Common
    EVERNOTE_HOST = 'www.evernote.com'
    EVERNOTE_DEVELOPER_TOKEN = ENV['EVERTILS_TOKEN']
  end
end
