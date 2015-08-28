class GPlace < Sequel::Model 
	set_dataset :GooglePlaces
end

class IGPlace < Sequel::Model 
	set_dataset :InstagramPlaces
end

class User < Sequel::Model 
	set_dataset :InstagramPlaces
end

class Post < Sequel::Model 
	set_dataset :InstagramPlaces
end

class Hashtag < Sequel::Model 
	set_dataset :InstagramPlaces
end

class PostTagMap < Sequel::Model 
	set_dataset :InstagramPlaces
end