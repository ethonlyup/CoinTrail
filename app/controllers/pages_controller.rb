class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def market_api
    @total_market = Coinmarketcap.coins(1000)
  end

  def market_price(b)
    b[:asset] = "BCH" if b[:asset] == "BCC"
    b[:asset] = 'MIOTA' if b[:asset] == 'IOTA'
    @total_market.select {|a| a["symbol"] == "#{b[:asset]}"}.first["price_usd"].to_f
  rescue
    0
  end

  def market_change(b)
    b[:asset] = "BCH" if b[:asset] == "BCC"
    b[:asset] = 'MIOTA' if b[:asset] == 'IOTA'
    @total_market.select {|c| c["symbol"] == "#{b[:asset]}"}.first["percent_change_24h"].to_f
    rescue
      0
  end

  def dashboard
    if current_user.apis.length == 2
      market_api
      binance_balance
      bittrex_balance
      set_total
    else
      redirect_to new_api_path, notice: "Please add an api before using dashboard"
    end
  end

  def binance_balance
    set_keys_binance
    Binance::Api::Configuration.api_key = @binance_publishable
    Binance::Api::Configuration.secret_key = @binance_secret
    @binance_account = Binance::Api.info!
    @binance_balance = Array.new
    @binance_account[:balances].each do |b|
    if (b[:free]).to_f > 0.00001 && b[:asset] != "EON"
      @binance_balance << {
        asset: b[:asset],
        price: market_price(b),
        holding: (b[:locked].to_f + b[:free].to_f).round(5),
        total: (b[:locked].to_f + b[:free].to_f) * market_price(b),
        change: market_change(b),
        alert: Alert.where(user: current_user, coin_name: b[:asset]).present?
      }
    end
  end
end

def bittrex_balance
  set_keys_bittrex
  Bittrex.config do |c|
    c.key = @bittrex_publishable
    c.secret = @bittrex_secret
  end
  @bittrex_balance = Array.new
  @bittrex_account = Bittrex::Wallet.all
  @bittrex_account.each do |b|
    if b.available + b.pending > 0.00000000
      @bittrex_balance << {
        asset: b.raw["Currency"],
        price: market_price(b),
        holding: b.available,
        total: b.available * market_price(b),
        alert: Alert.where(user: current_user, coin_name: b.raw["Currency"]).present?
      }
    end
  end
end

def set_total
  @total_balance = @binance_balance.dup
  @bittrex_balance.each do |b|
    exists = @binance_balance.index {|i| i[:asset] == b[:asset]}
    if exists.present?
     total = @total_balance[exists][:holding] + b[:holding]
     @total_balance[exists] = {
       asset: b[:asset],
       price: market_price(b),
       holding: total,
       total: total * market_price(b),
       change: market_change(b),
       alert: Alert.where(user: current_user, coin_name: b[:asset]).present?
     }
   else
    @total_balance << b
  end
end
@total_balance.sort_by! { |z| z[:total] }.reverse!
@total_sum = @total_balance.map {|h| h[:total]}.sum.round(2)
end

def set_keys_bittrex
  @bittrex_publishable = current_user.apis.where("exchange_id = 1").first.publishable_key
  @bittrex_secret = current_user.apis.where("exchange_id = 1").first.secret_key
end

def set_keys_binance
  @binance_publishable = current_user.apis.where("exchange_id = 2").first.publishable_key
  @binance_secret = current_user.apis.where("exchange_id = 2").first.secret_key
end

private :set_keys_binance, :set_keys_bittrex, :binance_balance

end
