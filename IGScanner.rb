# CLIENT ID	37d3719c83294335afe6a45aefa3a587
# CLIENT SECRET	1866abfe254b4313aeda776fb516ad3f
# WEBSITE URL	http://dabestappsever.com
# REDIRECT URI	http://dabestappsever.com
# SUPPORT EMAIL	dabestappsever@gmail.com

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
	accessToken = '1938599152.37d3719.2b75c578bdc546af91a0a6e30a43b6a1'
	locationIdFetchUrl = 'https://api.instagram.com/v1/locations/search?lat='+lat.to_s+'&lng='+lng.to_s+'&access_token='+accessToken
	locationIdFetchJSON = agent.get(locationIdFetchUrl).body
	locationIdFetchHash = JSON.parse(locationIdFetchJSON)
	locationId = targetLocationId(name, locationIdFetchHash)

	if(locationId===false)
		next
	end

	locationPostsUrl = 'https://api.instagram.com/v1/locations/'+locationId+'/media/recent?access_token='+accessToken
	postsDataJSON = agent.get(locationPostsUrl).body
	postsDataHash = JSON.parse(postsDataJSON)
}

