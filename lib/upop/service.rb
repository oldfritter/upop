#encoding: utf-8
module Upop
  module Service    
    
    DESKTOP_PAYMENT = %w( version charset transType merAbbr merId backEndUrl frontEndUrl orderTime orderNumber orderAmount orderCurrency customerIp )
    # Upop desktop payment
    def self.desktop_payment options={}
      options = {
        'version' => '1.0.0',
        'charset' => 'UTF-8',
        'transType' => '01',
        'merAbbr' => Upop.store_name
      }.merge(Utils.stringify_keys(options))
      check_required_options options, DESKTOP_PAYMENT
      options = options.merge({'signMethod' => 'MD5', 'signature' => Upop::Sign.generate(options)})

      options
    end
    
    DESKTOP_PAYMENT_INQUIRE = %w( version charset transType merAbbr merId orderTime orderNumber )
    # Upop payment inquire
    def self.desktop_payment_inquire options={}
      options = {'version' => '1.0.0', 'charset' => 'UTF-8', 'transType' => '01', 'merAbbr' => Upop.store_name}.merge(Utils.stringify_keys(options))
      check_required_options options, DESKTOP_PAYMENT_INQUIRE
      
      uri = URI.parse Upop.UPOP_TRADE_URL + "/UpopWeb/api/Query.action"
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true if uri.scheme == 'https'
      request = Net::HTTP::Post.new uri.request_uri
      request.body = query_string options
      response = http.request request
      

      CGI.parse(response.body)['transStatus'].first
    end
    
    def self.query_string(options)
      query = options.sort.concat([['signMethod', 'MD5'], ['signature', Upop::Sign.generate(options)]]).map do |key, value|
        "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
      end.join('&')
    end


    def self.check_required_options options, names
      names.each do |name|
        warn("Upop Warn: missing required option: #{name}") unless options.has_key?(name)
      end
    end
  end
end
