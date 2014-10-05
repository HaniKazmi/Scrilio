def fb text
  begin
    response = HTTParty.get(URI.encode("http://football-api.com/api/?Action=standings&APIKey=b89a5775-dcb4-a4d4-2ca9a2c98316&comp_id=1204"))
    d = JSON.parse(response.body)['teams']
    "#{text} is #{team_standing(d, text)} in the league"
    p response
  rescue
    "#{text} is not found"
  end
end

def team_standing(arr, text)
	for a in arr
		p a
		if a["stand_team_name"].downcase==text.downcase
			return a["stand_position"]
		end
	end
	"#{text} not found"
end