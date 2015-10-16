class Tag < ActiveRecord::Base
	def self.register_video user_id, fb_auth_id, tag_ids, lat, lng, title, seed_type
		#binding.pry
		link = SecureRandom.hex(10)
		user = User.find_by_user_id(user_id)
		#binding.pry
		if user.auth_token != fb_auth_id
			return "Wrong authentication", 0
		end
		if (user.nil?)
			return "User not found", 0
		else
			seed = Seed.new
			seed.title = title
			seed.is_public = seed_type
			seed.url = link
			seed.creator_id = user_id
			#binding.pry
			seed.save!
			query =  "UPDATE seeds SET coordinates  = ST_GeomFromText('POINT(#{lng} #{lat})', 4326) where id = #{seed.id}"
			Seed.connection.execute(query)
			tag = Tag.new
			tag.seed_id = seed.id
			tag.tagged_user_id = user_id
			tag.tagger_user_id = user_id
			tag.save!
			if !(tag_ids.nil?)
				tag_ids.each do |tag_id|
					tag = Tag.new
					tag.seed_id = seed.id
					tag.tagged_user_id = tag_id
					tag.tagger_user_id = user_id
					tag.save!
				end
			end
		end
		return link, 1
	end
end
