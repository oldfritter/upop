require "upop/version"
require 'upop/utils'
require 'upop/sign'
require 'upop/service'
require 'upop/notify'

module Upop
  
  class << self

    attr_accessor :store_no
    attr_accessor :store_name
    attr_accessor :key
    attr_accessor :UPOP_TRADE_URL
    attr_accessor :UPOP_QUERY_URL
  end
end
