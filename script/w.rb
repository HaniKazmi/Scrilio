def wikipedia sender
  begin
    response = HTTParty.get(URI.encode("http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=#{sender}&redirects"))
    d = JSON.parse(response.body).deep_find("extract")
    d.gsub(/<\/?..?>/, '')
  rescue
    "#{sender} not found"
  end
end
