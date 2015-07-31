## MYSQL CONNECT INFO HERE

DB.create_table? :InstagramPosts do 
	primary_key :Row
	Integer :ID, :unique=>true, :null=>false
	foreign_key :UserID, :InstagramUsers, :null=>false
	foreign_key :LocationID, :InstagramLocations, :null=>false, :index=>true
	Integer :CreatedTimeUnix, :null=>false
	varchar :PostURL, :null=>false
	varchar :ImageURL, :null=>false
	Fulltext :Caption
	unique [:ID, :UserID]
end

DB.create_table? :InstagramUsers do 
	primary_key :Row
	Integer :ID, :unique=>true, :null=>false
	varchar :Username, :unique=>true, :null=>false
	varchar :FullName
	varchar :ProfilePicURL
end

DB.create_table :InstagramPlaces do 
	primary_key :Row
	Integer :ID, :unique=>true, :null=>false
	Float :Latitude, :null=>false
	Float :Longitude, :null=>false
	varchar :PlaceName
end

DB.create_table? :InstagramHashtags do 
	primary_key :ID
	varchar :Hashtag, :unique=>true, :null=>false
end

DB.create_table? :InstagramPostTagMap do 
	primary_key :Row
	foreign_key :PostID, :InstagramPosts, :null=>false
	foreign_key :HashtagID, :InstagramHashtags, :null=>false
end
