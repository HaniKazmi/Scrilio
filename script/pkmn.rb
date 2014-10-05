require "pokegem"

def pkmn text
  response = Pokegem.get 'pokemon', text
  d = JSON.parse(response)["descriptions"][0]['resource_uri'].split('/')[-1]
  JSON.parse(Pokegem.get 'description', d)['description']
end