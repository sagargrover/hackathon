class TagController < ApplicationController
	skip_before_filter :verify_authenticity_token 
	def register_video
		url, status = Tag.register_video params[:user_id], params[:fb_auth_id], params[:tag_ids], params[:lat], params[:lng], params[:title], params[:seed_type]
		if status == 1
			render :json => {:messages => "Saved"}, :status => 402
		else
			render :json => {:url => url}, :status => :ok
		end
	end
end
