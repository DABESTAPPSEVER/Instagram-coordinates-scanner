def targetLocationId(name, locationIdFetchHash)
	locationIdFetchHash['data'].each{|location|
		if(location['name'].lowercase===name.lowercase)
			return location['id']
		end
	}
	return false
end