
A simple upop ruby gem, without unnecessary magic or wrapper, it's directly facing how UPOP api works.

This gem is just for desktop payment of UnionPay(UPOP).

## Installation

Add this line to your application's Gemfile:


```ruby
gem 'upop', :git => 'https://github.com/oldfritter/upop'
```

And then execute:

```sh
$ bundle install
```

## Usage

### Config

```ruby
  Upop.store_no = '105550149170027' # Your store NO.
  Upop.store_name = '上海一树网络科技有限公司' # Your company name.
  Upop.key = '88888888' # Your key.
  self.UPOP_TRADE_URL = 'https://unionpaysecure.com'
  self.UPOP_QUERY_URL = 'https://query.unionpaysecure.com'
```

### Generate payment options

```ruby
      @option = {
        merId: Upop.store_no,
        backEndUrl: notify_url,
        frontEndUrl: call_back_url,
        orderTime: Time.now.strftime('%Y%m%d%H%M%S'), 
        orderNumber: order.number,
        orderAmount: (order.amount * 100).to_i, 
        orderCurrency: 156, 
        customerIp: customer.ip
      } # 构建option
      
      @options = Upop::Service.desktop_payment @option

```

### Payment form
```ruby
<form id="union_pay_form" action="<%= Upop.UPOP_TRADE_URL %>/api/Pay.action" method='POST'>
  <input type="hidden" name='backEndUrl'			value='<%= @options['backEndUrl'] %>'/>
  <input type="hidden" name='charset'				value='<%= @options['charset'] %>'/>
  <input type="hidden" name='customerIp' 		value='<%= @options['customerIp'] %>'/>
  <input type="hidden" name='frontEndUrl'		value='<%= @options['frontEndUrl'] %>'/>
  <input type="hidden" name='merAbbr'				value='<%= @options['merAbbr'] %>'/>
  <input type="hidden" name='merId'					value='<%= @options['merId'] %>'/>
  <input type="hidden" name='orderAmount'		value='<%= @options['orderAmount'] %>'/>
  <input type="hidden" name='orderCurrency'	value='<%= @options['orderCurrency'] %>'/>
  <input type="hidden" name='orderNumber'		value='<%= @options['orderNumber'] %>'/>
  <input type="hidden" name='orderTime'			value='<%= @options['orderTime'] %>'/>
  <input type="hidden" name='orderTimeout'		value='<%= @options['orderTimeout'] %>'/>
  <input type="hidden" name='signMethod'			value='<%= @options['signMethod'] %>'/>
  <input type="hidden" name='signature'			value='<%= @options['signature'] %>'/>
  <input type="hidden" name='transType'			value='<%= @options['transType'] %>'/>
  <input type="hidden" name='version'				value='<%= @options['version'] %>'/>
	<input type='submit'/>
</form>
```

### Verify
```ruby
    def upop_notify
      return false unless Upop::Sign.verify? params.except('action', 'controller')
			# Do something.
      render text: 'success'
    end

    def upop_success
      return false unless Upop::Sign.verify? params.except('action', 'controller')
      # Do something.
      redirect_to #your success page.
    end

```

Current support payment type:
```
 Upop::Service.desktop_payment        	# 银联支付
 Upop::Service.desktop_payment_inquire  # 银联支付结果查询
```

## Contributing

Bug report or pull request are welcome.
My Email: leon.zcf(at)gmail.com
