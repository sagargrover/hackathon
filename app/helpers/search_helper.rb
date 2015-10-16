module SeachHelper
	def search_handles input
		ilike="handle ilike '%s'" % [input]
		User.where(ilike).select('user_id,name,handle').order(:handle)
	end
end