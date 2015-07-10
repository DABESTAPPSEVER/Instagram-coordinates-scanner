[
	'mechanize',
	'json'
].each{|g|
	require g
}

require_relative 'methods/methods.rb'

# SET UP AGENT
p "SETTING UP AGENT"
agent = Mechanize.new
agent.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE # Get around site's SSL problems

places.each{|place|
	name = place['name']
	coordinates = place['coordinates']
	lat = coordinate[0]
	lng = coordinate[1]
	accessToken = ARGV[0]
	locationIdFetchUrl = 'https://api.instagram.com/v1/locations/search?lat='+lat.to_s+'&lng='+lng.to_s+'&access_token='+accessToken
	locationIdFetchJSON = agent.get(locationIdFetchUrl).body
	locationIdFetchHash = JSON.parse(locationIdFetchJSON)

	# If the Levenshtein value is at least 15, 
	# the names of the IG place and the given place are too different
	igName = locationIdFetchHash['name']
	if(levenshtein(name,igName) >= 15)
		next
	end
	
	locationPostsUrl = 'https://api.instagram.com/v1/locations/'+locationId+'/media/recent?access_token='+accessToken
	postsDataJSON = agent.get(locationPostsUrl).body
	postsDataHash = JSON.parse(postsDataJSON)
	postsDataHash.each{|post|
		
	}
}

