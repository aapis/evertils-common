require 'evertils/common'
require 'evertils/test/base'

module Evertils

  #
  # @since 0.3.0
  def self.token
    ENV['EVERTILS_SB_TOKEN']
  end

  #
  # @since 0.3.0
  def self.host
    'sandbox.evernote.com'
  end

  #
  # @since 0.3.0
  def self.is_test?
    true
  end

  # define Test namespace
  # @since 0.3.0
  module Test
  end

end