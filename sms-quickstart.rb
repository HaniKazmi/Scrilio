require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'httparty'

post '/sms-quickstart' do
  sender = params[:Body]
  response = HTTParty.get("http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=#{sender}&redirects")
  d = JSON.parse(response.body).deep_find("extract")
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message d
  end
  twiml.text
end

class Hash
  def deep_find(key)
    key?(key) ? self[key] : self.values.inject(nil) {|memo, v| memo ||= v.deep_find(key) if v.respond_to?(:deep_find) }
  end
end
