require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'httparty'
Dir[File.dirname(__FILE__) + '/script/*.rb'].each {|file| require file }

get '/sms' do
  twiml = Twilio::TwiML::Response.new { |r| r.Message matcher params[:Body].split(" ") }
  twiml.text
end

def matcher sender
  begin
    send(sender[0].downcase, sender.drop(1).join(' '))
  rescue
    "#{sender.drop(1).join(' ')} not found"
  end
end