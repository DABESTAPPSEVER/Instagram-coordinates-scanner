[
	'mechanize',
	'json',
	'sequel',
	'pp'
].each{|g|
	require g
}

[
	'helpers/methods',
	'models/init'
].each{|rb|
	require_relative rb+'.rb'
}

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
	fetchLocationIDsURL = 'https://api.instagram.com/v1/locations/search?lat='+lat.to_s+'&lng='+lng.to_s+'&access_token='+accessToken
	fetchLocationIDsJSON = agent.get(fetchLocationIDsURL).body
	fetchLocationIDsHash = JSON.parse(fetchLocationIDsJSON)

	fetchLocationIDsHash['data'].each{|locationInfoHash|
		pp locationInfoHash,'==='

		igName = locationInfoHash['name']
		if(nameMatchFailCount(name,igName)===3)
			next
		end

		locationId = locationInfoHash['id']
		fetchPostsURL = 'https://api.instagram.com/v1/locations/'+locationId+'/media/recent?access_token='+accessToken
		postsJSON = agent.get(fetchPostsURL).body
		postsHash = JSON.parse(postsJSON)
		postsHash['data'].each{|post|
			pp post

			postID = post['id'].split('_')[0]
			# attribution = post['attribution'] # App connected to IG in this post.
			tagArray = post['tags']
			# type = post['type']
			
			locationHash = post['location']
			postLat = locationHash['latitude']
			postLon = locationHash['longitude']
			postLocationName = locationHash['name']
			postLocationID = locationHash['id']
			
			createdTimeUnix = post['created_time']
			postLink = post['link']
			standardResImage = post['images']['standard_resolution']['url']
			caption = post['caption']['text']

			userInfoHash = post['user']
			username = userInfoHash['username'] # May not need to display this
			userFullName = userInfoHash['full_name']
			userProfilePic = userInfoHash['profile_picture']
			userID = userInfoHash['id']

			pp [
				postID,
				# attribution,
				tagArray,
				# type,
				postLat,
				postLon,
				postLocationName,
				postLocationID,
				createdTimeUnix,
				postLink,
				standardResImage,
				caption,
				username,
				userFullName,
				userProfilePic,
				userID
			],
			'======='
		}
	}
}

