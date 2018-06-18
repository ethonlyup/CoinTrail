class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in?
      redirect_to dashboard_path
    end
  end

  def market_data

  end

  def dashboard
    if current_user.apis.exists?
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
      if (b[:free]).to_f > 0.00001
        price = rand(10..6500)
        @binance_balance<< {
          asset: b[:asset],
          price: price,
          holding: (b[:locked].to_f + b[:free].to_f).round(5),
          total: (b[:locked].to_f + b[:free].to_f) * price
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
    @bittrex_account.each do |c|
      if c.available + c.pending > 0.00000000
        price = rand(10..6500)
        @bittrex_balance << {
          asset: c.raw["Currency"],
          price: price,
          holding: c.available,
          total: c.available * price
        }
      end
    end
  end

  def set_total
    @total_balance = @binance_balance.dup
    @bittrex_balance.each do |c|
      exists = @binance_balance.index {|i| i[:asset] == c[:asset]}
      if exists.present?
       total = @total_balance[exists][:holding] + c[:holding]
       @total_balance[exists] = {
         asset: c[:asset],
         price: c[:price],
         holding: total,
         total: total * c[:price]
       }
     else
      @total_balance << c
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
