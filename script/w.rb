def w text
  begin
    response = HTTParty.get(URI.encode("http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=#{text}&redirects"))
    d = JSON.parse(response.body).deep_find("extract")
    d.gsub(/<\/?..?>/, '')
  rescue
    "#{text} not found"
  end
end
