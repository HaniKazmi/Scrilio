require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'httparty'
Dir[File.dirname(__FILE__) + '/script/*.rb'].each {|file| require file }

get '/sms' do
  begin
    sender = params[:Body].split(" ")
    twiml = Twilio::TwiML::Response.new { |r| r.Message matcher sender }
    twiml.text
  end
end

def matcher sender
  send(sender[0].downcase, sender.drop(1).join(' '))
end