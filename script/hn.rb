def hn text
  response = HTTParty.get(URI.encode('http://api.ihackernews.com/page'))
  JSON.parse(response.body)['items'][0]['title']
end