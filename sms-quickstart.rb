require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'httparty'

get '/sms-quickstart' do
  sender = params[:Body].split(" ")
  if sender[0] == 'w'
    wikipedia sender.drop(1).join(' ')
  end
end

def wikipedia sender
  begin
    response = HTTParty.get(URI.encode("http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=#{sender}&redirects"))
    d = JSON.parse(response.body).deep_find("extract")
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "#{d.gsub(/<\/?..?>/, '')}"
    end
    twiml.text
  rescue
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "#{sender} not found"
    end
    twiml.text
  end
end

class Hash
  def deep_find(key)
    key?(key) ? self[key] : self.values.inject(nil) {|memo, v| memo ||= v.deep_find(key) if v.respond_to?(:deep_find) }
  end
end
