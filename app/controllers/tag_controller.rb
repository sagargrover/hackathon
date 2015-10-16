class TagController < ApplicationController
	skip_before_filter :verify_authenticity_token 
	def register_video
		url, status = Tag.register_video params[:user_id], params[:fb_auth_id], params[:tag_ids], params[:lat], params[:lng], params[:title], params[:seed_type]
		if status == 1
			render :json => {:url => url}, :status => 400
		else
			render :json => {:url => "Problem"}, :status => 402
		end
	end
end
