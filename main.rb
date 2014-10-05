require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'httparty'

get '/sms' do
  sender = params[:Body].split(" ")
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message matcher sender
  end
  twiml.text
end

def matcher sender
  case sender[0].downcase
  when 'w'
    wikipedia sender.drop(1).join(' ')
  else
    wikipedia sender.join(' ')
  end
end

def wikipedia sender
  begin
    response = HTTParty.get(URI.encode("http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=#{sender}&redirects"))
    d = JSON.parse(response.body).deep_find("extract")
    d.gsub(/<\/?..?>/, '')
  rescue
    "#{sender} not found"
  end
end

class Hash
  def deep_find(key)
    key?(key) ? self[key] : self.values.inject(nil) {|memo, v| memo ||= v.deep_find(key) if v.respond_to?(:deep_find) }
  end
end