require 'evernote-thrift'
require 'notifaction'
require 'yaml'
require 'mime/types'
require 'date'

require 'evertils/common'
require 'evertils/test/base'

module Evertils
  module Test

    EVERNOTE_HOST = 'sandbox.evernote.com'
    EVERNOTE_DEVELOPER_TOKEN = ENV['EVERTILS_TOKEN']

  end
end
