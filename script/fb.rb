def fb text
  response = HTTParty.get(URI.encode("http://football-api.com/api/?Action=standings&APIKey=b89a5775-dcb4-a4d4-2ca9a2c98316&comp_id=1204"))
  p response
  pos = JSON.parse(response.body)['teams'].each { |a| if a["stand_team_name"].downcase==text.downcase; return "#{text} is #{a["stand_position"]} in the league" end }
end