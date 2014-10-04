require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
 
get '/sms-quickstart' do
  sender = params[:Body]
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message "Hello, Hani. Thanks for the message #{sender}."
  end
  twiml.text
end
