require 'rubygems'
require 'twilio-ruby'
 
account_sid = "ACf1f2b9431ed87c4c217f91ee52ee1950"
auth_token = "b1a2584f3a57bc615a6f56d4e66711ef"
client = Twilio::REST::Client.new account_sid, auth_token
 
from = "+442033897424" # Your Twilio number
 
friends = {
"+447449947575" => "Curious George",
}
friends.each do |key, value|
  client.account.messages.create(
    :from => from,
    :to => key,
    :body => "Hey #{value}, Monkey party at 6PM. Bring Bananas!"
  )
  puts "Sent message to #{value}"
end
