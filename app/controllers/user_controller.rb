class UserController < ApplicationController
	skip_before_filter :verify_authenticity_token 
	def new_user
		params_json = JSON.parse params["login_response"]
		flag = User.create params_json['id'], params_json['access_token'], params_json['name']
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
    return process_response([],200,params) if params[:input].count=0
    pattern='%s%' % [params[:input]]
    ilike="handle ilike '%s'" % [pattern]
    hits=User.where(ilike).select('user_id,name,handle').order(:handle).limit(5)
    puts hits.to_json
    process_response(hits,200,params)
  end

  def lookdown
    process_response("No, no, no. Look Up.",418,params)
  end

  def saw
    User.find_by(user_id:params[:user_id]).saw(params[:seed_id])
  end

	private
	def process_response response, status, params
    if status == 200 || status == 418
      render json: response, status: status, callback: params[:callback]
    elsif status == 500
      raise response
    else
      handle_logging(response, status, params)
      render json: RESPONSE[status], status: status, callback: params[:callback]
    end
  end

  def log_file(file_name = "Polygon")
    file_str = File.join "#{Rails.root}","log", "#{file_name}.log"
    File.new(file_str,"w") unless File.exists?(file_str)
    log_file = Logger.new(file_str)
    log_file
  end

  def handle_logging response, status, params
    action = params["action"]
    log_file.error "#{action} || #{status} || #{response} || #{params.except!("controller","action")}"
  end

  def init_api # :nodoc:
  end
end
