# def targetLocationId(name, locationIdFetchHash)
# 	locationIdFetchHash['data'].each{|location|
# 		if(location['name'].lowercase===name.lowercase)
# 			return location['id']
# 		end
# 	}
# 	return false
# end

# http://stackoverflow.com/questions/16323571/measure-the-distance-between-two-strings-with-ruby
def levenshtein(s, t)
	m = s.length
	n = t.length
	return m if n == 0
	return n if m == 0
	d = Array.new(m+1) {Array.new(n+1)}

	(0..m).each {|i| d[i][0] = i}
	(0..n).each {|j| d[0][j] = j}
	(1..n).each do |j|
		(1..m).each do |i|
			d[i][j] = if s[i-1] == t[j-1]	# adjust index into string
									d[i-1][j-1]			 # no operation required
								else
									[ d[i-1][j]+1,		# deletion
										d[i][j-1]+1,		# insertion
										d[i-1][j-1]+1,	# substitution
									].min
								end
		end
	end
	d[m][n]
end

def nameMatchFailCount(name,igName)
	nameDowncase = name.downcase
	igNameDowncase = igName.downcase

	failCount = 0

	# If the Levenshtein value is at least X, 
	# the names of the IG place and the given place are too different
	if(levenshtein(name,igName) >= 10)
		failCount+=1
		p "LEVENSHTEIN TEST FAILED: COMPARED #{name} AND #{igName}"
	end

	if(igNameDowncase.include?(nameDowncase)===false)
		failCount+=1
		p "PLACE NAME #{name} NOT IN INSTAGRAM NAME #{igName}"
	end

	if(nameDowncase.include?(igNameDowncase)===false)
		failCount+=1
		p "INSTAGRAM NAME #{igName} NOT IN PLACE NAME #{name}"
	end	 

	return failCount	
end