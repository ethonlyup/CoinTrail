class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in?
      redirect_to dashboard_path
    end
  end

  def dashboard
    binance_balance
  end

  def binance_balance
    set_keys_binance
    Binance::Api::Configuration.api_key = @binance_publishable
    Binance::Api::Configuration.secret_key = @binance_secret
    @binance_account = Binance::Api.info!
    @balances = Array.new
    coin = Hash.new
    # btcval = Binance::Api.ticker!(symbol: "BTCUSDT", type: 'price')
    # btc_usdt = btcval[:price].to_f
    @binance_account[:balances].each do |b|
      if (b[:free]).to_f > 0.00001
        # unless b[:asset] == "EON"
        #   if b[:asset] == "BTC"
        #     dollar_value = b[:free].to_f * btc_usdt
        #     dollar_value.round(4)
        price = rand(10..6500)
        @balances << {
          asset: b[:asset],
          # free: b[:free],
          # locked: b[:locked],
          price: price,
          holding: (b[:locked].to_f + b[:free].to_f).round(5),
          total: (b[:locked].to_f + b[:free].to_f) * price
            }
        #   else
        #     pair_price =  Binance::Api.ticker!(symbol: b[:asset]+'BTC', type: 'price')
        #     holding_val = b[:free].to_f * pair_price[:price].to_f
        #     dollar_value = holding_val * btc_usdt
        #     dollar_value.round(4)
        #     coin = {
        #       asset: b[:asset],
        #       free: b[:free],
        #       locked: b[:locked],
        #       fiat: dollar_value
        #     }
        #     @balances << coin
        #   end
        # end
      end
    end
    @balances.sort_by! { |z| z[:total] }.reverse!
    @total_sum = @balances.map{|s| s[:total]}.sum.round(0)
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
