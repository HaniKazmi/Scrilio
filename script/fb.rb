def fb text
  begin
    if text.downcase=="live"
      response = HTTParty.get(URI.encode("http://football-api.com/api/?Action=today&APIKey=b89a5775-dcb4-a4d4-2ca9a2c98316&comp_id=1204")
      s = JSON.parse(response.body)
      p s
      "#{s["match_ht_score"]}"
    else
      response = HTTParty.get(URI.encode("http://football-api.com/api/?Action=standings&APIKey=b89a5775-dcb4-a4d4-2ca9a2c98316&comp_id=1204"))
      p response
      pos = JSON.parse(response.body)['teams'].each { |a| if a["stand_team_name"].downcase==text.downcase; return a["stand_position"] end }
      "#{text} is #{pos} in the league"
    end
  rescue
    "#{text} not found"
  end
end