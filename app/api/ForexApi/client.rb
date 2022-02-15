module ForexApi
  class Client
    include HTTParty

    base_uri "http://api.currencylayer.com"

    @datapath="app/api/ForexApi/countries_currency.csv"

    def self.convert_to_currency(alphcode, amount)
      amount = amount.to_f
      currencies = "#{alphcode},PHP"
      if alphcode
        options = { query: {
          access_key: ENV.fetch("FOREX_API_KEY") {Rails.application.credentials.forex_api_key},
          currencies: "#{alphcode},PHP"
          }
        }
        res = HTTParty.get("#{base_uri}/live",options)
        if res["quotes"]
          if res["quotes"]["USD#{alphcode}"]
            res["converted_amount"] = amount * res["quotes"]["USD#{alphcode}"] / res["quotes"]["USDPHP"]
          end
        else
          res["converted_amount"] = 0
        end
        self.process_res(res)
      else
        res["code"]=200
        res["data"]="Country not found"
        self.process_res(res)
      end
    end

    def self.convert_to_country(country, amount)
      amount = amount.to_f
      alphcode = find_currency(country)
      currencies = "#{alphcode},PHP"
      if alphcode
        options = { query: {
          access_key: ENV.fetch("FOREX_API_KEY") {Rails.application.credentials.forex_api_key},
          currencies: "#{alphcode},PHP"
          }
        }
        res = HTTParty.get("#{base_uri}/live",options)
        if res["quotes"]
          if res["quotes"]["USD#{alphcode}"]
            res["converted_amount"] = amount * res["quotes"]["USD#{alphcode}"] / res["quotes"]["USDPHP"]
          end
        else
          res["converted_amount"] = 0
        end
        self.process_res(res)
      else
        res["code"]=200
        res["data"]="Country not found"
        self.process_res(res)
      end
    end

    def self.find_currency(country)
      data = File.open(@datapath)
      currencies = CSV.parse(data, headers: true).map(&:to_h)
      
      ele = currencies.detect {|item| item["Entity"] == country.upcase}
      if ele
        ele["AlphabeticCode"]
      else
        nil
      end
    end

    private

    def self.process_res(res)
      case res.code
        when 200
          {code: res.code, status: 'success', data: res.parsed_response}
        when 401
          {code: res.code, status: 'Unauthorized request'}
        when 404
          {code: res.code, status: 'Not found'}
        when 500...600
          {code: res.code, status: 'Error'}
      end
    end
  end
end

