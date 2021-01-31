require "openweather_map/version"

module OpenweatherMap
  require 'net/http'
  require 'json'

  def self.get_current_weather(city, api_key)
    url = URI("http://api.openweathermap.org/data/2.5/weather?q=#{city}&lang=pt_br&units=metric&appid=#{api_key}")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    par_res = JSON.parse(res.body)
    par_res['main']['temp']
  end

  def self.get_forecast(city, api_key)
    url = URI.parse("http://api.openweathermap.org/data/2.5/forecast?q=#{city}&lang=pt_br&cnt=5&units=metric&appid=#{api_key}")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    par_res = JSON.parse(res.body)
    par_res['list'].map { |item| {item['dt_txt']=>  item['main']['temp']} }
  end
end
