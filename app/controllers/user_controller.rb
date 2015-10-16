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

	def get_handle
		handle = User.find_by_user_id(params[:user_id]).handle
		render :json => {:handle => handle}, :status => :ok
	end

end
