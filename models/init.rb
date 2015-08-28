## MYSQL CONNECT INFO HERE
DB = Sequel.connect(
	:adapter => 'mysql',
	:user => ENV['MYSQL_USERNAME'],
	:password => ENV['MYSQL_PASSWORD'],
	:host => ENV['MYSQL_HOST'],
	:database => ENV['MYSQL_DATABASE']
)

DB.create_table? :InstagramPlaces do 
	primary_key :Row
	Integer :ID, :unique=>true, :null=>false
	foreign_key :GooglePlaceID, :key=>:ID, :null=>false
	Float :Latitude, :null=>false
	Float :Longitude, :null=>false
	varchar :Name, :null=>false
end

DB.create_table? :InstagramUsers do 
	primary_key :Row
	Integer :ID, :unique=>true, :null=>false
	varchar :Username, :unique=>true, :null=>false
	varchar :FullName
	varchar :ProfilePicURL
end

DB.create_table? :InstagramPosts do 
	primary_key :Row
	Integer :ID, :unique=>true, :null=>false
	foreign_key :UserID, :InstagramUsers, :key=>:ID, :null=>false
	foreign_key :LocationID, :InstagramPlaces, :key=>:ID, :null=>false, :index=>true
	Integer :CreatedTimeUnix, :null=>false
	varchar :PostURL, :null=>false
	varchar :ImageURL, :null=>false
	Text :Caption
	unique [:ID, :UserID]
end

DB.create_table? :InstagramHashtags do 
	primary_key :ID
	varchar :Hashtag, :unique=>true, :null=>false
end

DB.create_table? :InstagramPostTagMap do 
	primary_key :Row
	foreign_key :PostID, :InstagramPosts, :key=>:ID, :null=>false
	foreign_key :HashtagID, :InstagramHashtags, :null=>false
end

require_relative 'classes.rb'