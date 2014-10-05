require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'httparty'
Dir[File.dirname(__FILE__) + '/script/*.rb'].each {|file| require file }

get '/sms' do
  begin
    sender = params[:Body].split(" ")
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message matcher sender
    end
    twiml.text
  rescue
  end
end

def matcher sender
  l = sender[0].downcase
  send(l, sender.drop(1).join(' '))
end

def method_missing(meth, *args, &block)
  send('w', *args.drop(1).join(' '))
end

class Hash
  def deep_find(key)
    key?(key) ? self[key] : self.values.inject(nil) {|memo, v| memo ||= v.deep_find(key) if v.respond_to?(:deep_find) }
  end
end