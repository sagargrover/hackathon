class UserController < ApplicationController
	skip_before_filter :verify_authenticity_token 
	def new_user
		flag = User.create params[:user_id], params[:fb_auth_token], params[:name]
		if flag == 1
	      render :json => {:messages => "Saved"}, :status => :ok
	    else
	      render :json => {:messages => "Not Saved"}, :status => 422
	    end
	end

end
