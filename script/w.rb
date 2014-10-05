def w text
  begin
    response = HTTParty.get(URI.encode("http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=#{text}&redirects"))
    d = JSON.parse(response.body).deep_find("extract")
    d.gsub(/<\/?..?>/, '')
  rescue
    "#{text} not found"
  end
end

class Hash
  def deep_find(key)
    key?(key) ? self[key] : self.values.inject(nil) {|memo, v| memo ||= v.deep_find(key) if v.respond_to?(:deep_find) }
  end
end