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

	def myplants
		mine=User.find_by(user_id:params[:user_id]).myplants
		process_response(mine,200,params)
	end

	def myseeds
		mine=User.find_by(user_id:params[:user_id]).myseeds
		process_response(mine,200,params)
	end

  def suggest
    ilike="handle ilike '%s'" % [params[:input]]
    hits=User.where(ilike).select('user_id,name,handle').order(:handle)
    process_response(hits,200,params)
  end

  def saw
    User.find_by(user_id:params[:user_id]).saw(params[:seed_id])
  end

	private
	def process_response response, status, params
    if status == 200
      render json: response, status: status, callback: params[:callback]
    elsif status == 500
      raise response
    else
      handle_logging(response, status, params)
      render json: RESPONSE[status], status: status, callback: params[:callback]
    end
  end

  def init_api # :nodoc:
  end
end
